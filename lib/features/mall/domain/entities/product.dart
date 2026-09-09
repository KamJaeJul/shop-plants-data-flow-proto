class Product {
  const Product({
    required this.id,
    required this.price,
    required this.name,
    this.isPromotion = false,
    this.originalPrice,
  });
  final int id;
  final double price;
  final String name;
  final bool isPromotion;
  final double? originalPrice;
}
