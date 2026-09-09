import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/theme/app_colors.dart';
import 'app_bottom_nav_bar.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({
    required this.pageName,
    required this.selectedNavigationIndex,
    this.embedded = false,
    this.onBack,
    super.key,
  });

  final String pageName;
  final int selectedNavigationIndex;
  final bool embedded;
  final VoidCallback? onBack;

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  bool _hasStartedEntrance = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    final entranceCurve = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );
    _fadeAnimation = entranceCurve;
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.12),
      end: Offset.zero,
    ).animate(entranceCurve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStartedEntrance) return;

    _hasStartedEntrance = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _entranceController.value = 1;
    } else {
      _entranceController.forward();
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comingSoonImage = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Image.asset(
        'assets/image/coming-soon.png',
        fit: BoxFit.contain,
        semanticLabel:
            '${widget.pageName} page is being worked on and is coming soon',
      ),
    );

    final body = SafeArea(
      bottom: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: MediaQuery.disableAnimationsOf(context)
                  ? comingSoonImage
                  : RepaintBoundary(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: comingSoonImage,
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Semantics(
              button: true,
              label: 'Back',
              child: Material(
                color: Colors.transparent,
                child: InkResponse(
                  onTap: widget.onBack ?? () => Navigator.maybePop(context),
                  radius: 24,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: Image.asset(
                        'assets/icon/Icon - Arrow.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.contain,
                        excludeFromSemantics: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.whiteBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: widget.embedded
          ? ColoredBox(color: AppColors.whiteBackground, child: body)
          : Scaffold(
              backgroundColor: AppColors.whiteBackground,
              body: body,
              bottomNavigationBar: AppBottomNavBar(
                selectedIndex: widget.selectedNavigationIndex,
                onItemSelected: (index) {
                  if (index == widget.selectedNavigationIndex) return;

                  if (index == 0) {
                    context.go(AppRoutes.home);
                    return;
                  }

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
