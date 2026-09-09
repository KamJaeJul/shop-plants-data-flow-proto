part of '../home_page.dart';

class _PrimaryActions extends StatelessWidget {
  const _PrimaryActions();

  static const _actions = [
    ('Shop', 'assets/buttons/Button - Shop.png'),
    ('Services', 'assets/buttons/Button - Services.png'),
    ('Posts', 'assets/buttons/Button - Posts.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
      child: Row(
        children: [
          for (var index = 0; index < _actions.length; index++) ...[
            if (index > 0) const SizedBox(width: 10),
            Expanded(
              child: _EntranceMotion(
                beginOffset: const Offset(0.12, 0),
                delay: Duration(milliseconds: 55 * index),
                child: Semantics(
                  button: true,
                  label: _actions[index].$1,
                  excludeSemantics: true,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 44),
                      child: AspectRatio(
                        aspectRatio: 250 / 130,
                        child: Image.asset(
                          _actions[index].$2,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryCarousel extends StatelessWidget {
  const _CategoryCarousel({required this.assets});

  final List<String> assets;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Row(
        children: [
          for (var index = 0; index < assets.length; index++) ...[
            if (index > 0) const SizedBox(width: 10),
            _EntranceMotion(
              beginOffset: const Offset(0.17, 0),
              delay: Duration(milliseconds: 55 * index),
              child: Semantics(
                button: true,
                label: 'Plant category ${index + 1}',
                excludeSemantics: true,
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: Image.asset(
                    assets[index],
                    width: 76,
                    height: 76,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EntranceMotion extends StatefulWidget {
  const _EntranceMotion({
    super.key,
    required this.child,
    required this.beginOffset,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
  });

  final Widget child;
  final Offset beginOffset;
  final Duration delay;
  final Duration duration;

  @override
  State<_EntranceMotion> createState() => _EntranceMotionState();
}

class _EntranceMotionState extends State<_EntranceMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _position;
  ScrollPosition? _verticalScrollPosition;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    final totalDuration = widget.delay + widget.duration;
    _controller = AnimationController(duration: totalDuration, vsync: this);

    final animationStart =
        widget.delay.inMicroseconds / totalDuration.inMicroseconds;
    final entranceCurve = CurvedAnimation(
      parent: _controller,
      curve: Interval(animationStart, 1, curve: const Cubic(0.16, 1, 0.3, 1)),
    );
    _opacity = entranceCurve;
    _position = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(entranceCurve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) {
      _showFinalState();
      return;
    }

    final nextPosition = Scrollable.maybeOf(
      context,
      axis: Axis.vertical,
    )?.position;
    if (_verticalScrollPosition != nextPosition) {
      _verticalScrollPosition?.removeListener(_showWhenVisible);
      _verticalScrollPosition = nextPosition;
      _verticalScrollPosition?.addListener(_showWhenVisible);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _showWhenVisible());
  }

  void _showWhenVisible() {
    if (!mounted || _hasPlayed) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final top = renderObject.localToGlobal(Offset.zero).dy;
    final bottom = top + renderObject.size.height;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    if (bottom > 0 && top < viewportHeight) {
      _hasPlayed = true;
      _verticalScrollPosition?.removeListener(_showWhenVisible);
      _controller.forward();
    }
  }

  void _showFinalState() {
    _hasPlayed = true;
    _verticalScrollPosition?.removeListener(_showWhenVisible);
    _controller.value = 1;
  }

  @override
  void dispose() {
    _verticalScrollPosition?.removeListener(_showWhenVisible);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FadeTransition(
        opacity: _opacity,
        alwaysIncludeSemantics: true,
        child: SlideTransition(position: _position, child: widget.child),
      ),
    );
  }
}
