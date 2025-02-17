import 'package:flutter/material.dart';
import 'package:eccomerce/Homescreen.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
