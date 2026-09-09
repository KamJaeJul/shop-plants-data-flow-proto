import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key,
  }) : assert(selectedIndex >= 0 && selectedIndex < _items.length);

  static const _items = [
    _NavigationItem(
      label: 'Home',
      asset: 'assets/nav-icon/Nav Icon - Home.png',
      activeAsset: 'assets/nav-icon/Nav Icon - Home Green.png',
    ),
    _NavigationItem(
      label: 'Mall',
      asset: 'assets/nav-icon/Nav Icon - Mall.png',
      activeAsset: 'assets/nav-icon/Nav Icon - Mall Green.png',
    ),
    _NavigationItem(
      label: 'Discover',
      asset: 'assets/nav-icon/Nav Icon - Discover.png',
    ),
    _NavigationItem(
      label: 'Inbox',
      asset: 'assets/nav-icon/Nav Icon - Inbox.png',
    ),
    _NavigationItem(
      label: 'Account',
      asset: 'assets/nav-icon/Nav Icon - Account.png',
    ),
  ];

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteBackground,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Column(
            children: [
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.navigationDivider,
              ),
              Expanded(
                child: Row(
                  children: [
                    for (var index = 0; index < _items.length; index++)
                      Expanded(
                        child: Semantics(
                          container: true,
                          button: true,
                          selected: index == selectedIndex,
                          label: _items[index].label,
                          onTap: () => onItemSelected(index),
                          excludeSemantics: true,
                          child: InkWell(
                            onTap: () => onItemSelected(index),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  index == selectedIndex
                                      ? _items[index].activeAsset ??
                                            _items[index].asset
                                      : _items[index].asset,
                                  width: 28,
                                  height: 28,
                                  fit: BoxFit.contain,
                                  color:
                                      index == selectedIndex &&
                                          _items[index].activeAsset == null
                                      ? AppColors.primary
                                      : null,
                                  colorBlendMode: BlendMode.srcIn,
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      _items[index].label.toUpperCase(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: index == selectedIndex
                                            ? AppColors.primary
                                            : AppColors.navigationInactive,
                                        fontFamily: AppTypography.fontFamily,
                                        fontSize: 10,
                                        fontWeight: AppTypography.regular,
                                        letterSpacing: 1.2,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem({
    required this.label,
    required this.asset,
    this.activeAsset,
  });

  final String label;
  final String asset;
  final String? activeAsset;
}
