import 'package:flutter/material.dart';

import '../../../shared/widgets/coming_soon_page.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({this.embedded = false, this.onBack, super.key});

  final bool embedded;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return ComingSoonPage(
      pageName: 'Inbox',
      selectedNavigationIndex: 3,
      embedded: embedded,
      onBack: onBack,
    );
  }
}
