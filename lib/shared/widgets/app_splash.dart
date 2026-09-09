import 'package:flutter/material.dart';

const _logoAsset = 'assets/plants-category/Shop Plants - Icon Main Padded.png';

class AppSplash extends StatefulWidget {
  const AppSplash({required this.child, this.enabled = true, super.key});

  final Widget child;
  final bool enabled;

  @override
  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  bool _started = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _finished = !widget.enabled;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );
    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 62),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 38,
      ),
    ]).animate(_controller);
    _scale = Tween<double>(begin: 0.94, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.58, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_finished || _started) return;

    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.duration = const Duration(milliseconds: 300);
    }
    _controller.forward().whenCompleteOrCancel(() {
      if (mounted) setState(() => _finished = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) return widget.child;

    return ColoredBox(
      key: const ValueKey('app-splash'),
      color: Colors.white,
      child: Center(
        child: Semantics(
          label: 'Shop Plants',
          image: true,
          child: ExcludeSemantics(
            child: FadeTransition(
              opacity: _opacity,
              child: ScaleTransition(
                scale: _scale,
                child: Image.asset(
                  _logoAsset,
                  width: 190,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
