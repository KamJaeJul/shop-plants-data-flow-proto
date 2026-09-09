import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/home_content.dart';
import 'state/home_state.dart';
import 'viewmodels/home_view_model.dart';
import 'widgets/locations_map.dart';

import '../../../core/navigation/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_bottom_nav_bar.dart';

part 'widgets/discoveries.dart';
part 'widgets/locations.dart';
part 'widgets/services.dart';
part 'widgets/appointment.dart';
part 'widgets/home_actions.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({this.embedded = false, super.key});

  final bool embedded;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _categoryAssets = [
    'assets/buttons/Button - Icon 1.png',
    'assets/buttons/Button - Icon 2.png',
    'assets/buttons/Button - Icon 3.png',
    'assets/buttons/Button - Icon 4.png',
    'assets/buttons/Button - Icon 5.png',
  ];

  static const _plantCategoryAssets = [
    'assets/plants-category/Shop Plants - Icon 1.png',
    'assets/plants-category/Shop Plants - Icon 2.png',
    'assets/plants-category/Shop Plants - Icon 3.png',
    'assets/plants-category/Shop Plants - Icon 4.png',
    'assets/plants-category/Shop Plants - Icon 5.png',
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final body = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AppointmentHeader(state: state),
          _EntranceMotion(
            key: const ValueKey('home-banner-entrance'),
            beginOffset: const Offset(0, -0.11),
            duration: const Duration(milliseconds: 760),
            child: AspectRatio(
              aspectRatio: 828 / 500,
              child: Image.asset(
                'assets/image/Home Banner.jpg',
                fit: BoxFit.cover,
                semanticLabel: 'Indoor potted plant',
              ),
            ),
          ),
          const _PrimaryActions(),
          _CategoryCarousel(assets: _categoryAssets),
          _NewServicesSection(
            services: state.content.services,
            categoryAssets: _plantCategoryAssets,
          ),
          _TrendingDiscoveriesSection(discoveries: state.content.discoveries),
          _LocationsSection(locations: state.content.locations),
        ],
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.whiteBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: widget.embedded
          ? ColoredBox(color: AppColors.whiteBackground, child: body)
          : Scaffold(
              backgroundColor: AppColors.whiteBackground,
              body: body,
              bottomNavigationBar: AppBottomNavBar(
                selectedIndex: 0,
                onItemSelected: (index) {
                  final routeName = AppRoutes.forNavigationIndex(index);
                  if (routeName != null) {
                    context.go(routeName);
                  }
                },
              ),
            ),
    );
  }
}
