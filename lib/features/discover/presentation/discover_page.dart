import 'package:flutter/material.dart';

import '../../../shared/widgets/coming_soon_page.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({this.embedded = false, this.onBack, super.key});

  final bool embedded;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return ComingSoonPage(
      pageName: 'Discover',
      selectedNavigationIndex: 2,
      embedded: embedded,
      onBack: onBack,
    );
  }
}
