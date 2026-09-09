import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';

class MallState {
  MallState({
    required List<Product> products,
    required List<Product> visibleProducts,
    this.filter = const ProductFilter(),
  }) : products = List.unmodifiable(products),
       visibleProducts = List.unmodifiable(visibleProducts);
  final List<Product> products;
  final List<Product> visibleProducts;
  final ProductFilter filter;
}
