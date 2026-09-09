part of '../mall_page.dart';

class _MallSearchHeader extends StatelessWidget {
  const _MallSearchHeader({
    required this.controller,
    required this.onBack,
    required this.onChanged,
    required this.onFilter,
  });

  final TextEditingController controller;
  final VoidCallback onBack;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteBackground,
      elevation: 2,
      shadowColor: const Color(0x22000000),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 14, 12),
        child: Row(
          children: [
            Semantics(
              button: true,
              label: 'Back',
              child: InkResponse(
                onTap: onBack,
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
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.whiteBackground,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  key: const ValueKey('mall-search-field'),
                  controller: controller,
                  onChanged: onChanged,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search Salon',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Image.asset(
                        'assets/icon/Icon - Search.png',
                        excludeFromSemantics: true,
                      ),
                    ),
                    suffixIcon: Semantics(
                      button: true,
                      label: 'Open filters',
                      child: InkResponse(
                        onTap: onFilter,
                        radius: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Image.asset(
                            'assets/icon/Icon - Filter.png',
                            excludeFromSemantics: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MallProductCard extends StatelessWidget {
  const _MallProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: ValueKey('mall-product-${product.id}'),
      button: true,
      label: product.semanticLabel,
      excludeSemantics: true,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shadowColor: const Color(0x18000000),
        color: AppColors.whiteBackground,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/image/Image - Item.jpg',
                      fit: BoxFit.cover,
                      excludeFromSemantics: true,
                    ),
                    if (product.isPromotion)
                      Positioned(
                        top: 10,
                        right: 8,
                        child: Image.asset(
                          'assets/image/50-off.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                          excludeFromSemantics: true,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lorem Ipsum',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 12,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 14,
                        fontWeight: AppTypography.bold,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (product.originalPrice case final originalPrice?)
                      Text(
                        'RM ${originalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Text(
                      'RM ${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.priceText,
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 15,
                        fontWeight: AppTypography.regular,
                        fontFeatures: [FontFeature.tabularFigures()],
                        height: 1.3,
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

class _StaggeredEntrance extends StatelessWidget {
  const _StaggeredEntrance({
    required this.controller,
    required this.index,
    required this.productId,
    required this.child,
  });

  final AnimationController controller;
  final int index;
  final int productId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;

    final start = (index * 0.055).clamp(0.0, 0.28);
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );

    return RepaintBoundary(
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          key: ValueKey('mall-product-slide-$productId'),
          position: Tween<Offset>(
            begin: const Offset(0.18, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
    );
  }
}

class _EmptyMallResults extends StatelessWidget {
  const _EmptyMallResults({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'No plants match your search.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: AppTypography.fontFamily,
                fontSize: 16,
                fontWeight: AppTypography.medium,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: onReset, child: const Text('RESET FILTERS')),
          ],
        ),
      ),
    );
  }
}

extension ProductPresentation on Product {
  String get semanticLabel {
    final promotion = isPromotion ? ', 50 percent promotion' : '';
    return 'Plant $id, Lorem ipsum, RM ${price.toStringAsFixed(2)}$promotion';
  }
}

class _MallFilters {
  const _MallFilters({
    required this.priceRange,
    required this.promotionOnly,
    required this.sort,
  });

  final RangeValues priceRange;
  final bool promotionOnly;
  final ProductSort sort;
}
