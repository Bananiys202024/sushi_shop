import 'package:flutter/material.dart';
import 'package:flutter_app/core/entity/product.dart';

Widget pattern_ordered_items(Product product, int price) {
  return new Column(
    children: <Widget>[
      Card(
        child: ListTile(
          leading: SizedBox(
              height: 60,
              width: 80,
              child: product.image == null || product.image == ''
                  ? Image(image: AssetImage('assets/images/default.jpeg'))
                  : Image.network(product.image)),
          title: Text(product.name),
          subtitle: Text(price.toString() + "p"),
          trailing: new Text('x' + product.quantity.toString()),
        ),
      ),
    ],
  );
}
