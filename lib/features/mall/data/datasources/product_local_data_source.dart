import '../../domain/entities/product.dart';

class ProductLocalDataSource {
  const ProductLocalDataSource();
  static const products = [
    Product(
      name: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      id: 1,
      price: 100,
    ),
    Product(
      name: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      id: 2,
      price: 50,
      isPromotion: true,
      originalPrice: 100,
    ),
    Product(
      name: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      id: 3,
      price: 100,
    ),
    Product(
      name: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      id: 4,
      price: 50,
      isPromotion: true,
      originalPrice: 100,
    ),
    Product(
      name: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      id: 5,
      price: 80,
    ),
    Product(
      name: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      id: 6,
      price: 40,
      isPromotion: true,
      originalPrice: 80,
    ),
  ];

  List<Product> load() => List.unmodifiable(products);
}
