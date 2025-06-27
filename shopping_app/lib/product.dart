class Product {
  final String name;
  final String brand;
  final double price;
  final int id;
  int quantity=1;
  final String imageUrl;
  Product(this.id, {
    required this.name,required this.brand,required this.price,required this.imageUrl,
  });

}
