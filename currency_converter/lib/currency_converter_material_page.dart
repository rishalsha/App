import 'package:flutter/material.dart';

class CurrencyConverterMaterialPagee extends StatefulWidget {
  const CurrencyConverterMaterialPagee({super.key});

  @override
  State createState() => _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState extends State {
  double result = 0;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const myBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(96, 102, 37, 253)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Dollar Converter",
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rs ${result != 0 ? result.toStringAsFixed(2) : '0'}",
              style: TextStyle(
                fontSize: 50,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 50),
              child: TextField(
                controller: textEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter the amount in USD",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixText: "    ",
                  suffixIcon: Icon(Icons.monetization_on),
                  suffixIconColor: Colors.white70,
                  border: myBorder,
                  enabledBorder: myBorder,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  try {
                    result = (double.parse(textEditingController.text) * 86.25);
                  } catch (e) {
                    result = 0;
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.deepPurpleAccent,
                ),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),

              child: Text("  Convert  "),
            ),
          ],
        ),
      ),
    );
  }
}
