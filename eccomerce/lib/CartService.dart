import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eccomerce/Model.dart';

class CartService {
  static const String cartKey = 'cart_items';

  // Add product to cart
  static Future<void> addToCart(Model product) async {
    final prefs = await SharedPreferences.getInstance();
    List<Model> cart = await getCartItems();

    // Check if the product is already in the cart
    int index = cart.indexWhere((item) => item.id == product.id);
    if (index == -1) {
      cart.add(product);
    }

    // Save the updated cart
    List<String> cartJson = cart.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(cartKey, cartJson);
  }

  // Retrieve cart items
  static Future<List<Model>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList(cartKey);

    if (cartJson != null) {
      return cartJson.map((item) => Model.fromJson(jsonDecode(item))).toList();
    }
    return [];
  }

  // Remove item from cart
  static Future<void> removeFromCart(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<Model> cart = await getCartItems();

    cart.removeWhere((item) => item.id == id);

    List<String> cartJson = cart.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(cartKey, cartJson);
  }

  // Clear the cart
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }
}
