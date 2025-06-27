import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/shopping_cart.dart';

class CartScreen extends StatefulWidget {

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);
    return  Center(
      child: Text(cart.items.toString()),

    );
  }
}
