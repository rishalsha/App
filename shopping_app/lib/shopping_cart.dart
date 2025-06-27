
import 'package:flutter/foundation.dart';
import 'package:shopping_app/product.dart';

class ShoppingCart extends ChangeNotifier {

  int get itemcount{
    return items.length;
  }

  double get total_price{
    double total=0;
    items.map((item) {
      total+=item.price;
    });
    return total;
  }
  List<Product> items = [];
  void addItem(Map<String,dynamic>data) {

      items.add(Product(data['id'],brand: data['brand'],
      price: data['price'],
      name: data['name'],
      imageUrl: data['image']
      ));
    notifyListeners();
    
  }
  void removItem(){
    notifyListeners();
  }
}
