import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/repositories/location_launcher.dart';

class GoogleMapsLauncher implements LocationLauncher {
  const GoogleMapsLauncher();
  @override
  Future<bool> open(StoreLocation location) async {
    final uri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': '${location.latitude},${location.longitude}',
    });
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
