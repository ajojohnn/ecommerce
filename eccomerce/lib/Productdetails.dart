import 'package:eccomerce/Model.dart';
import 'package:flutter/material.dart';

class Productdetails extends StatelessWidget {
  Model model;
  Productdetails({super.key, required this.model, required int index});
  final GlobalKey widgetKey = GlobalKey();
// final void Function(GlobalKey) onClick;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(model.image),
          Text('${model.price} \$'),
          Text(model.description),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.orange),
              Text('${model.rating}'),
            ],
          ),
        ],
      ),
    );
  }
}
