import 'package:flutter/material.dart';
import 'package:eccomerce/Model.dart';
import 'package:eccomerce/Productdetails.dart';
import 'package:eccomerce/CartService.dart';

// ignore: must_be_immutable
class Modelcard extends StatelessWidget {
  Model model;
  Modelcard({super.key, required this.model});
  void addToCartHandler(BuildContext context) async {
    await CartService.addToCart(model);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${model.title} added to cart!')),
    );
  }

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // this is the coloumn
          children: [
            AspectRatio(
              aspectRatio: 1, // this is the ratio
              child: Image.network(model.image),
            ),
            ListTile(
              title: Text(model.title),
              subtitle: Text(
                  '${model.price} \$'), // this is fetch the price from the api
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star,
                      color: Colors.orange), // this will give the rating
                  Text('${model.rating}'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => addToCartHandler(context),
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  CachedNetworkImage({required String imageUrl, required BoxFit fit}) {}
}
