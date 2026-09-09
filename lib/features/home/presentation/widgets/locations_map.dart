import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import '../../../../core/config/app_environment.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/home_content.dart';

class LocationsMap extends StatefulWidget {
  const LocationsMap({
    required this.locations,
    required this.center,
    super.key,
  });

  final List<StoreLocation> locations;
  final ({double latitude, double longitude}) center;

  @override
  State<LocationsMap> createState() => _LocationsMapState();
}

class _LocationsMapState extends State<LocationsMap> {
  bool _isStyleLoading = true;
  bool _didStyleFail = false;

  @override
  Widget build(BuildContext context) {
    final hasMapboxToken = AppEnvironment.mapboxAccessToken.isNotEmpty;

    return Semantics(
      image: true,
      label: hasMapboxToken
          ? 'Mapbox map showing ${widget.locations.length} store locations'
          : 'Mapbox map requires an access token',
      child: ExcludeSemantics(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 194,
            child: hasMapboxToken
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      MapWidget(
                        key: const ValueKey('locations-map'),
                        styleUri: '',
                        viewport: CameraViewportState(
                          center: Point(
                            coordinates: Position(
                              widget.center.longitude,
                              widget.center.latitude,
                            ),
                          ),
                          zoom: 12.3,
                        ),
                        onMapCreated: _configureMap,
                      ),
                      if (_isStyleLoading || _didStyleFail)
                        ColoredBox(
                          color: AppColors.greyBackground,
                          child: Center(
                            child: _didStyleFail
                                ? const Text(
                                    'Map preview unavailable',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontFamily: AppTypography.fontFamily,
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  )
                                : const SizedBox.square(
                                    dimension: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primary,
                                    ),
                                  ),
                          ),
                        ),
                    ],
                  )
                : const ColoredBox(
                    key: ValueKey('locations-map'),
                    color: AppColors.greyBackground,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'Map preview unavailable',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _configureMap(MapboxMap mapboxMap) async {
    try {
      await mapboxMap.gestures.updateSettings(
        GesturesSettings(
          rotateEnabled: false,
          pinchToZoomEnabled: false,
          scrollEnabled: false,
          simultaneousRotateAndPinchToZoomEnabled: false,
          pitchEnabled: false,
          doubleTapToZoomInEnabled: false,
          doubleTouchToZoomOutEnabled: false,
          quickZoomEnabled: false,
          pinchPanEnabled: false,
        ),
      );
      await mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
      await mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

      final styleJson = await rootBundle.loadString('assets/mapbox_style.json');
      final style = jsonDecode(styleJson) as Map<String, dynamic>;
      final sources = style['sources'] as Map<String, dynamic>;
      final stores = sources['stores'] as Map<String, dynamic>;
      stores['data'] = {
        'type': 'FeatureCollection',
        'features': [
          for (final location in widget.locations)
            {
              'type': 'Feature',
              'properties': {'name': location.name},
              'geometry': {
                'type': 'Point',
                'coordinates': [location.longitude, location.latitude],
              },
            },
        ],
      };

      await mapboxMap.loadStyleJson(jsonEncode(style));
      if (!mounted) return;
      setState(() => _isStyleLoading = false);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isStyleLoading = false;
        _didStyleFail = true;
      });
    }
  }
}
