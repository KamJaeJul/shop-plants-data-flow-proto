enum ProductSort { featured, priceLowToHigh, priceHighToLow }

class ProductFilter {
  const ProductFilter({
    this.query = '',
    this.minPrice = 0,
    this.maxPrice = 120,
    this.promotionOnly = false,
    this.sort = ProductSort.featured,
  });
  final String query;
  final double minPrice;
  final double maxPrice;
  final bool promotionOnly;
  final ProductSort sort;
  ProductFilter copyWith({
    String? query,
    double? minPrice,
    double? maxPrice,
    bool? promotionOnly,
    ProductSort? sort,
  }) => ProductFilter(
    query: query ?? this.query,
    minPrice: minPrice ?? this.minPrice,
    maxPrice: maxPrice ?? this.maxPrice,
    promotionOnly: promotionOnly ?? this.promotionOnly,
    sort: sort ?? this.sort,
  );
}
