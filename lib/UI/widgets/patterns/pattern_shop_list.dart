import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/patterns/pattern_card.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PatternShopList extends StatefulWidget {
  List<Product> products;

  PatternShopList({Key key, this.products}) : super(key: key);

  @override
  _PatternShopListState createState() => _PatternShopListState();
}

class _PatternShopListState extends State<PatternShopList> {
  @override
  Widget build(BuildContext context) {

    if(widget.products == null)
      {
          return message_about_empty_categorie();
      }
    else {
      return GridView.count(
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        shrinkWrap: true,
        children: <Widget>[
          if(widget.products != null)
            for (int i = 0; i < widget.products.length; i++)
              create_card(widget.products[i]),
        ],
      );
    };
  }

  Widget create_card(Product product) {
    return ScopedModelDescendant<CardModel>(
      builder: (context, child, model) {
        return Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              PatternCard(
                  message: 'get_top_part_of_card',
                  product: product,
                  model: model),
              PatternCard(
                  message: 'get_middle_card_1', product: product, model: model),
              PatternCard(
                  message: 'get_middle_card_2', product: product, model: model),
              PatternCard(
                  message: 'get_bottom_card', product: product, model: model),
            ],
          ),
        );
      },
    );
  }

  Widget message_about_empty_categorie()
  {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top:10.0, left: 20.0, right: 20.0),
          child: Text("This categorie empty", style: TextStyle(fontSize: 20, color: Colors.grey)),
        ),
      )
    );

  }
} //end class
