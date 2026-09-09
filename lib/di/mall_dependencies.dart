import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/mall/data/datasources/product_local_data_source.dart';
import '../features/mall/data/repositories/local_product_repository.dart';
import '../features/mall/domain/repositories/product_repository.dart';
import '../features/mall/domain/usecases/get_products.dart';
import '../features/mall/domain/usecases/filter_products.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => const LocalProductRepository(ProductLocalDataSource()),
);
final getProductsProvider = Provider(
  (ref) => GetProducts(ref.watch(productRepositoryProvider)),
);
final filterProductsProvider = Provider((ref) => const FilterProducts());
