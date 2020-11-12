import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/flutter_widgets/divider.dart';
import 'package:flutter_app/UI/widgets/fragments/patterns/pattern_ordered_item_inside_shop_bucket_on_tab_order_on_final_tab_of_order.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/models/card_model.dart';

Widget show_ordered_items(CardModel model) {
  int total_price = 0;

  //get total price
  List<Product> list = model.get_all();
  for (int i = 0; i < list.length; i++)
    total_price += list[i].price *  list[i].quantity;
  //...

  return new Column(
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: new Text(
            "Your order",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      get_devider(),
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: model.get_all().length,
        itemBuilder: (context, pos) {
          Product product = model.get_all()[pos];
          //just to get price as int
          int quantity = product.quantity;
          String string_price = product.price.toString()+"p";
          string_price = string_price.substring(0, string_price.length - 1);
          int price = int.parse(string_price) * product.quantity;
          //...

          return pattern_ordered_items(product, price);
        },
      ),
      get_devider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            'Total',
            style: TextStyle(fontSize: 20),
          ),
          new Text(
            total_price.toString() + "p",
            style: TextStyle(fontSize: 20),
          ),
        ],
      )
    ],
  );
}
