import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/account/presentation/account_page.dart';
import '../../features/discover/presentation/discover_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/inbox/presentation/inbox_page.dart';
import '../../features/mall/presentation/mall_page.dart';
import '../../shared/widgets/app_bottom_nav_bar.dart';
import 'app_routes.dart';

GoRouter createAppRouter({String? initialLocation}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(embedded: true),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.mall,
              builder: (context, state) => MallPage(
                embedded: true,
                onBack: () => context.go(AppRoutes.home),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.discover,
              builder: (context, state) => DiscoverPage(
                embedded: true,
                onBack: () => context.go(AppRoutes.home),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.inbox,
              builder: (context, state) => InboxPage(
                embedded: true,
                onBack: () => context.go(AppRoutes.home),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.account,
              builder: (context, state) => AccountPage(
                embedded: true,
                onBack: () => context.go(AppRoutes.home),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page not found')),
    body: Center(
      child: FilledButton(
        onPressed: () => context.go(AppRoutes.home),
        child: const Text('Go to Home'),
      ),
    ),
  ),
);

class _MainShell extends StatelessWidget {
  const _MainShell({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: AppBottomNavBar(
      selectedIndex: navigationShell.currentIndex,
      onItemSelected: (index) => navigationShell.goBranch(index),
    ),
  );
}
