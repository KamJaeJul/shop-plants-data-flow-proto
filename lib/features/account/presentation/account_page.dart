import 'package:flutter/material.dart';

import '../../../shared/widgets/coming_soon_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({this.embedded = false, this.onBack, super.key});

  final bool embedded;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return ComingSoonPage(
      pageName: 'Account',
      selectedNavigationIndex: 4,
      embedded: embedded,
      onBack: onBack,
    );
  }
}
