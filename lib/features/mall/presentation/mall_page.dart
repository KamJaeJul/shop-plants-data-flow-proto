import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/product.dart';
import '../domain/entities/product_filter.dart';
import 'viewmodels/mall_view_model.dart';
import 'package:flutter/services.dart';

import '../../../core/navigation/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_bottom_nav_bar.dart';

part 'widgets/mall_widgets.dart';

class MallPage extends ConsumerStatefulWidget {
  const MallPage({this.embedded = false, this.onBack, super.key});

  final bool embedded;
  final VoidCallback? onBack;

  @override
  ConsumerState<MallPage> createState() => _MallPageState();
}

class _MallPageState extends ConsumerState<MallPage>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late final AnimationController _entranceController;
  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 720),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _entranceController.value = 1;
      } else {
        _entranceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(mallViewModelProvider).visibleProducts;
    final body = SafeArea(
      bottom: false,
      child: Column(
        children: [
          _MallSearchHeader(
            controller: _searchController,
            onBack: widget.onBack ?? () => Navigator.maybePop(context),
            onChanged: ref.read(mallViewModelProvider.notifier).setQuery,
            onFilter: _showFilters,
          ),
          Expanded(
            child: ColoredBox(
              color: AppColors.greyBackground,
              child: products.isEmpty
                  ? _EmptyMallResults(onReset: _resetFilters)
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final columns = width >= 840
                            ? 4
                            : width >= 600
                            ? 3
                            : 2;
                        final textScale = MediaQuery.textScalerOf(
                          context,
                        ).scale(1).clamp(1.0, 2.0);
                        final cardExtent = 312 + ((textScale - 1) * 84);

                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 960),
                            child: GridView.custom(
                              key: const ValueKey('mall-product-grid'),
                              padding: const EdgeInsets.fromLTRB(
                                22,
                                20,
                                22,
                                28,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: columns,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: cardExtent,
                                  ),
                              childrenDelegate: SliverChildListDelegate([
                                for (
                                  var index = 0;
                                  index < products.length;
                                  index++
                                )
                                  _StaggeredEntrance(
                                    controller: _entranceController,
                                    index: index,
                                    productId: products[index].id,
                                    child: _MallProductCard(
                                      product: products[index],
                                    ),
                                  ),
                              ]),
                            ),
                          ),
                        );
                      },
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
                selectedIndex: 1,
                onItemSelected: (index) {
                  if (index == 0) {
                    context.go(AppRoutes.home);
                    return;
                  }

                  final routeName = AppRoutes.forNavigationIndex(index);
                  if (index != 1 && routeName != null) {
                    context.go(routeName);
                  }
                },
              ),
            ),
    );
  }

  void _resetFilters() {
    _searchController.clear();
    ref.read(mallViewModelProvider.notifier).resetFilters();
  }

  Future<void> _showFilters() async {
    final filter = ref.read(mallViewModelProvider).filter;
    var draftPriceRange = RangeValues(filter.minPrice, filter.maxPrice);
    var draftPromotionOnly = filter.promotionOnly;
    var draftSort = filter.sort;

    final result = await showModalBottomSheet<_MallFilters>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.whiteBackground,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                24,
                4,
                24,
                24 + MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'FILTER & SORT',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 20,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Price range  •  RM ${draftPriceRange.start.round()} – RM ${draftPriceRange.end.round()}',
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: AppTypography.medium,
                        ),
                      ),
                      RangeSlider(
                        values: draftPriceRange,
                        min: 0,
                        max: 120,
                        divisions: 12,
                        labels: RangeLabels(
                          'RM ${draftPriceRange.start.round()}',
                          'RM ${draftPriceRange.end.round()}',
                        ),
                        onChanged: (value) =>
                            setSheetState(() => draftPriceRange = value),
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Promotion only'),
                        value: draftPromotionOnly,
                        onChanged: (value) => setSheetState(
                          () => draftPromotionOnly = value ?? false,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Sort by',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: AppTypography.medium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<ProductSort>(
                        showSelectedIcon: false,
                        segments: const [
                          ButtonSegment(
                            value: ProductSort.featured,
                            label: Text('Featured'),
                          ),
                          ButtonSegment(
                            value: ProductSort.priceLowToHigh,
                            label: Text('Price ↑'),
                          ),
                          ButtonSegment(
                            value: ProductSort.priceHighToLow,
                            label: Text('Price ↓'),
                          ),
                        ],
                        selected: {draftSort},
                        onSelectionChanged: (selection) =>
                            setSheetState(() => draftSort = selection.first),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () => Navigator.pop(
                          context,
                          _MallFilters(
                            priceRange: draftPriceRange,
                            promotionOnly: draftPromotionOnly,
                            sort: draftSort,
                          ),
                        ),
                        child: const Text('APPLY FILTERS'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    if (result == null || !mounted) return;
    ref
        .read(mallViewModelProvider.notifier)
        .applyFilters(
          ref
              .read(mallViewModelProvider)
              .filter
              .copyWith(
                minPrice: result.priceRange.start,
                maxPrice: result.priceRange.end,
                promotionOnly: result.promotionOnly,
                sort: result.sort,
              ),
        );
  }
}
