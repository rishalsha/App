import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/navigator_page.dart';
import 'package:shopping_app/shopping_cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shopping App",
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        fontFamily: "Lato",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
      ),
      home: ChangeNotifierProvider(create: (_) => ShoppingCart(),
      child: NavigatorPage(),)
    );
  }
}
