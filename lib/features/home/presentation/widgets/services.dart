part of '../home_page.dart';

class _NewServicesSection extends StatelessWidget {
  const _NewServicesSection({
    required this.services,
    required this.categoryAssets,
  });

  final List<ServiceItem> services;
  final List<String> categoryAssets;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(
      context,
    ).scale(1).clamp(1, 2).toDouble();

    return ColoredBox(
      color: AppColors.greyBackground,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _EntranceMotion(
              beginOffset: Offset(0.09, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _SectionHeader(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 294 + ((textScale - 1) * 116),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: services.length,
                separatorBuilder: (_, _) => const SizedBox(width: 6),
                itemBuilder: (context, index) => _EntranceMotion(
                  beginOffset: const Offset(0.12, 0),
                  delay: Duration(milliseconds: 60 * index),
                  child: _ServiceCard(service: services[index]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _PlantCategorySlider(assets: categoryAssets),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NEW SERVICES',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 16,
                  fontWeight: AppTypography.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Recommended based on your preference',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 12,
                  fontWeight: AppTypography.regular,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: AppColors.secondaryText,
            minimumSize: const Size(64, 48),
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.topRight,
          ),
          child: const Text(
            'View All',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 12,
              fontWeight: AppTypography.regular,
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${service.title}, RM ${service.price.toStringAsFixed(2)}',
      excludeSemantics: true,
      child: SizedBox(
        width: 177,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: AppColors.whiteBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: AppColors.navigationDivider),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ExcludeSemantics(
                  child: Image.asset(
                    service.imageAsset,
                    height: 177,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.eyebrow,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 12,
                            fontWeight: AppTypography.regular,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          service.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: AppTypography.bold,
                            height: 1.35,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'RM ${service.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.priceText,
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: AppTypography.regular,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlantCategorySlider extends StatefulWidget {
  const _PlantCategorySlider({required this.assets});

  final List<String> assets;

  @override
  State<_PlantCategorySlider> createState() => _PlantCategorySliderState();
}

class _PlantCategorySliderState extends State<_PlantCategorySlider> {
  final ScrollController _controller = ScrollController();
  double _scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (!_controller.hasClients) return;
    final maxExtent = _controller.position.maxScrollExtent;
    final progress = maxExtent == 0 ? 0.0 : _controller.offset / maxExtent;
    if (progress != _scrollProgress) {
      setState(() => _scrollProgress = progress.clamp(0, 1).toDouble());
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_updateProgress)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 82,
          child: Row(
            children: [
              Semantics(
                button: true,
                label: 'Shop plants',
                excludeSemantics: true,
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 112,
                    height: 82,
                    child: Image.asset(
                      'assets/plants-category/Shop Plants - Icon Main.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView.separated(
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(10, 8, 24, 8),
                      itemCount: widget.assets.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => _EntranceMotion(
                        key: ValueKey('home-category-entrance-$index'),
                        beginOffset: const Offset(0.18, 0),
                        delay: Duration(milliseconds: 55 * index),
                        child: Semantics(
                          button: true,
                          label: 'Shop plants category ${index + 1}',
                          excludeSemantics: true,
                          child: InkWell(
                            onTap: () {},
                            customBorder: const CircleBorder(),
                            child: Image.asset(
                              widget.assets[index],
                              width: 62,
                              height: 62,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 24,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.greyBackground,
                                AppColors.greyBackground.withValues(alpha: 0),
                              ],
                            ),
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
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const thumbWidth = 46.0;
              final travel = (constraints.maxWidth - thumbWidth)
                  .clamp(0, double.infinity)
                  .toDouble();

              return SizedBox(
                height: 6,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(height: 1, color: AppColors.buttonPrimary),
                    Transform.translate(
                      offset: Offset(travel * _scrollProgress, 0),
                      child: Container(
                        width: thumbWidth,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 3,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
