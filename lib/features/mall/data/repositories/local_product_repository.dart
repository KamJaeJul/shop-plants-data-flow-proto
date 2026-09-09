import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

class LocalProductRepository implements ProductRepository {
  const LocalProductRepository(this.source);
  final ProductLocalDataSource source;
  @override
  List<Product> getProducts() => source.load();
}
