import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/models/product.dart';
import 'package:flutter_app/core/util/counter.dart';

class PatternShopBucketCard extends StatefulWidget {

  Product product;
  CardModel model;
  int quantity;

  PatternShopBucketCard({Key key, this.product, this.model}) : super(key: key);

  @override
  _PatternShopBucketCardState createState() => _PatternShopBucketCardState();
}

class _PatternShopBucketCardState extends State<PatternShopBucketCard> {

  final TextEditingController eCtrl = new TextEditingController();
  num _defaultValue = 1;

  @override
  Widget build(BuildContext context) {

    String quantity = widget.model.get_quantity_by_id(widget.product.id);
    debugPrint("Quantity in build method--"+ quantity);
    this._defaultValue = int.parse(quantity);

    return new Column(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: get_leading(widget.product),
            title: Text(widget.product.name),
            subtitle: Text(widget.product.price),
            trailing: get_counter(widget.model, widget.product),
          ),
        ),
      ],
    );
  }

  Widget _incrementButton(Product product, CardModel model) {
    return new InkWell(
      onTap: () {
        add(product, model);
      },
      child: Container(
        width: 20,
        height: 20,
        child: new FloatingActionButton(
          heroTag: 'increment_button_' + product.id,
          onPressed: add(product, model),
          child: new Icon(
            Icons.add_circle_outline,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _decrementButton(Product product, CardModel model) {
    return new InkWell(
        onTap: () {
          minus(product, model);
        },
        child: Container(
          width: 20,
          height: 20,
          child: new FloatingActionButton(
            heroTag: "decrement_button_" + product.id,
//          onPressed: ,
            child: new Icon(
              Icons.remove_circle_outline,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
        ));
  }

  minus(Product product, CardModel model) {
    debugPrint("You did click minus");
    model.minus_quantity(product);
  }

  add(Product product, CardModel model) {
    debugPrint("You did click plus");
    model.add_quantity(product);
  }

  Widget get_counter(CardModel model, Product product) {
    return
      new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Counter(
      color: Colors.grey,
      buttonSize: 24,
      model: model,
      id_of_model: product.id,
      heroTag: product.id,
      initialValue: _defaultValue,
      minValue: 0,
      maxValue: 10000,
      step: 1,
      decimalPlaces: 1,
      onChanged: (value) { // get the latest value from here
        setState(() {

          if(value < _defaultValue && value != -1) minus(product, model);
          if(value > _defaultValue) add(product, model);

          debugPrint("Default value---"+_defaultValue.toString());
          debugPrint("Value--"+value.toString());

          _defaultValue = value;
        });
      },
    ),
        ],
      );
  }

  Widget get_leading(Product product)
  {
   return  SizedBox(
      height: 60,
      width: 80,
      child: Image(
        image: AssetImage(
            product.image + product.id + '.png'),
      ),
    );
  }
}
