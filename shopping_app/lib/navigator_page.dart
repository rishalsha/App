import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_screen.dart';
import 'package:shopping_app/home_page.dart';
import 'package:shopping_app/shopping_cart.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 0;
  final List<Widget> pages = [HomePage(),CartScreen()];
  @override
  Widget build(BuildContext context) {

final cart = Provider.of<ShoppingCart>(context);

    return Scaffold(
      body: pages[_currentIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart (${cart.itemcount})'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index){
            _currentIndex = index;
            setState(() {

            });

        },
      ),
    );
  }
}
