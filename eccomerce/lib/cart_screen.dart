import 'package:flutter/material.dart';
import 'package:eccomerce/CartService.dart';
import 'package:eccomerce/Model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Model> cart = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    List<Model> loadedCart = await CartService.getCartItems();
    setState(() {
      cart = loadedCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: cart.isEmpty
          ? Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.network(item.image, width: 50, height: 50),
                  title: Text(item.title),
                  subtitle: Text("\$${item.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await CartService.removeFromCart(item.id);
                      loadCart();
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await CartService.clearCart();
                  loadCart();
                },
                child: Text('Clear Cart'),
              ),
            )
          : null,
    );
  }
}
