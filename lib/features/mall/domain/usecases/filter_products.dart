import '../entities/product.dart';
import '../entities/product_filter.dart';

class FilterProducts {
  const FilterProducts();
  List<Product> call(List<Product> products, ProductFilter filter) {
    final query = filter.query.trim().toLowerCase();
    final result = products
        .where(
          (product) =>
              '${product.name} plant ${product.id}'.toLowerCase().contains(
                query,
              ) &&
              product.price >= filter.minPrice &&
              product.price <= filter.maxPrice &&
              (!filter.promotionOnly || product.isPromotion),
        )
        .toList();
    switch (filter.sort) {
      case ProductSort.featured:
        break;
      case ProductSort.priceLowToHigh:
        result.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHighToLow:
        result.sort((a, b) => b.price.compareTo(a.price));
    }
    return List.unmodifiable(result);
  }
}
