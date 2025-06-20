import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filter = const ['All', 'Adidas', 'Puma', 'Nike', 'Reebok'];

  List<Map<String, dynamic>> dummyShoeData = [
    {
      "name": "Air Max 270",
      "brand": "Nike",
      "price": 129.99,
      "image": "https://picsum.photos/300/300",
    },
    {
      "name": "Ultraboost 22",
      "brand": "Adidas",
      "price": 179.99,
      "image": "https://picsum.photos/300/300",
    },
    {
      "name": "Classic Leather",
      "brand": "Reebok",
      "price": 89.99,
      "image": "https://picsum.photos/300/300",
    },
    {
      "name": "Chuck Taylor All Star",
      "brand": "Nike",
      "price": 55.00,
      "image": "https://picsum.photos/300/300",
    },
    {
      "name": "Suede Classic XXI",
      "brand": "Puma",
      "price": 65.00,
      "image": "https://picsum.photos/300/300",
    },
  ];
  final searchBox = TextEditingController();
  List<Map<String, dynamic>> get filteredData {
    if (selectedFilter == 'All' && searchBox.text.isEmpty) return dummyShoeData;
    if (selectedFilter != 'All') {
      searchBox.text.toLowerCase();
      return dummyShoeData
          .where(
            (item) => searchBox.text.isEmpty
                ? item['brand'] == selectedFilter
                : item['name'].toString().toLowerCase().contains(
                        searchBox.text.toLowerCase(),
                      ) &&
                      item['brand'] == selectedFilter,
          )
          .toList();
    }
    return dummyShoeData
        .where(
          (item) => item['name'].toString().toLowerCase().contains(
            searchBox.text.toLowerCase(),
          ),
        )
        .toList();
  }

  late String selectedFilter;

  @override
  void initState() {
    selectedFilter = filter[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Shoes\nCollection",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchBox,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filter.length,
                itemBuilder: (context, index) {
                  final currentFilter = filter[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = currentFilter;
                        });
                      },
                      child: Chip(
                        backgroundColor: currentFilter == selectedFilter
                            ? Colors.cyanAccent
                            : Color.fromARGB(255, 240, 243, 243),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(30),
                          ),
                        ),
                        side: BorderSide(
                          color: const Color.fromARGB(255, 231, 235, 235),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),

                        label: Text(
                          filter[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final data = filteredData[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 12,
                      vertical: 20,
                    ),
                    child: SizedBox(
                      height: 400,

                      child: Card(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsetsGeometry.only(left: 30),
                                child: Text(
                                  data['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(left: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '\$${data["price"]}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            Image.network('https://picsum.photos/300/300'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
