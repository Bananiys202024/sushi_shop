import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/models/product.dart';

class PatternCard extends StatefulWidget {
  Product product;
  final String title = "atomic sushi";
  String message;
  CardModel model;

  PatternCard({Key key, this.product, this.message, this.model})
      : super(key: key);

  @override
  _PatternCardState createState() => _PatternCardState();
}

class _PatternCardState extends State<PatternCard> {
  @override
  Widget build(BuildContext context) {

    if (widget.message == 'get_top_part_of_card') return get_top_part_of_card();

    if (widget.message == 'get_middle_card_1')
      return middle_card_1(widget.product);

    if (widget.message == 'get_middle_card_2')
      return middle_card_2(widget.product);

    if (widget.message == 'get_bottom_card')
      return bottom_card(widget.product, widget.model);
  }

  Widget get_top_part_of_card() {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: widget.product.is_favorite
                ? Icon(
                    Icons.favorite,
                    color: Colors.yellow,
                    size: 26.0,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 26.0,
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.0, top: 0.0),
            child: widget.product.is_new
                ? Icon(
                    Icons.fiber_new_outlined,
                    color: Colors.green,
                    size: 40.0,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget middle_card_1(Product product) {
    return Expanded(
      flex: 2,
      child: Image(
        image: AssetImage(product.image + product.id + '.png'),
      ),
    );
  }

  Widget middle_card_2(Product product) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            product.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget bottom_card(Product product, CardModel model) {
    return product.old_price != null
        ? bottom_card_with_old_price(product, model)
        : bottom_card_just_simple_price(product, model);
  }

  Widget bottom_card_with_old_price(Product product, CardModel model) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Container(
                      decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(4.0),
                              topRight: const Radius.circular(4.0),
                              bottomLeft: const Radius.circular(4.0),
                              bottomRight: const Radius.circular(4.0))),
                      child: new Center(
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(product.price,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Text(
                      product.old_price,
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Transform.translate(
                offset: Offset(10, -10),
                child: InkWell(
                  child: IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      model.add(product);
                    },
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottom_card_just_simple_price(Product product, CardModel model) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Container(
                      child: new Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(product.price,
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Transform.translate(
                offset: Offset(10, -10),
                child: InkWell(
                  child: IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      model.add(product);
                    },
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } //end method

}
