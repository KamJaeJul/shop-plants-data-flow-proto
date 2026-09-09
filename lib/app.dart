import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/widgets/app_splash.dart';

class PlantShopApp extends StatefulWidget {
  const PlantShopApp({this.showSplash = false, super.key});
  final bool showSplash;

  @override
  State<PlantShopApp> createState() => _PlantShopAppState();
}

class _PlantShopAppState extends State<PlantShopApp> {
  late final GoRouter _router = createAppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Plant Shop',
    theme: AppTheme.light,
    routerConfig: _router,
    builder: (context, child) =>
        AppSplash(enabled: widget.showSplash, child: child!),
  );
}
