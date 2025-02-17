import 'dart:convert';
import 'package:eccomerce/Productdetails.dart';
import 'package:flutter/material.dart';
import 'package:eccomerce/Model.dart';
import 'package:http/http.dart' as http;
import 'package:eccomerce/ModelCard.dart';
import 'dart:async';
import 'package:eccomerce/Productdetails.dart';
import 'package:eccomerce/cart_screen.dart';

class Homescreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  List<Model> models = [];
  List<Model> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(_filterProducts);
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        models = jsonData.map((data) => Model.fromJson(data)).toList();
      });
    } else {}
  }

  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = models.where((model) {
        return model.title.toLowerCase().contains(query) ||
            model.category.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                })
          ],
          toolbarHeight: 150,
          backgroundColor: const Color.fromARGB(255, 38, 5, 184),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Productdetails(
                                      model: models[index],
                                      index: index,
                                    )));
                      },
                      child: Modelcard(model: filteredProducts[index]));
                }),
          )
        ]));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
