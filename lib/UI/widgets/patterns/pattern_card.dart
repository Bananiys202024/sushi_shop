import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/flutter_widgets/alert_dialog.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/login_or_registration/options/get_currently_logged_user.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableProducts.dart';
import 'package:provider/provider.dart';

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

  FirebaseAuth _auth = FirebaseAuth.instance;


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

    String currenly_logged_user = get_currently_logged_user(_auth);

    debugPrint("Refreshed");
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: check_if_currently_logged_user_inside_list(
                    widget.product.favorite_for_users, currenly_logged_user),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0),
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
    debugPrint("IsImageEmptyFromMethodMiddleCard1---" + product.image);
    return product.image == ''
        ? Expanded(
            flex: 2,
            child: Image.asset("assets/images/default.jpeg"),
          )
        : Expanded(
            flex: 2,
            child: Image.network(product.image),
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
                          child: Text(product.price.toString() + "p",
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
                      product.old_price.toString() + "p",
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
                            child: Text(product.price.toString() + "p",
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
  }

  check_if_currently_logged_user_inside_list(
      List<dynamic> favorite_for_users, String currenly_logged_user) {

    debugPrint("Control check list--"+favorite_for_users.toString());

    var _productProvider = Provider.of<CRUDModelForTableProducts>(context);

    bool result = false;

    debugPrint("This is control check---" + favorite_for_users.toString());

    if (favorite_for_users != null)
      for (String name in favorite_for_users) {
        if (name == currenly_logged_user) {
          result = true;
        }
      }

    debugPrint("result result---" + result.toString());

    if (favorite_for_users == null || favorite_for_users.length == 0) {
         return IconButton(
           icon: Icon(Icons.favorite_border, color: Colors.grey, size: 26.0),
           onPressed: () {

             bool is_user_anonymyouse = _auth.currentUser.isAnonymous;

             if(is_user_anonymyouse) {
               showMyDialog(context, false, 'Log in',
                   'You are anonymouse user for now. You need to log in to add this product to favorites. You can do it in side menu in personal cabinet.', 'Okey');
             }
             else
             {

               debugPrint("Current user--"+_auth.currentUser.toString());
               debugPrint("Logged User---"+currenly_logged_user);
               widget.product.add_item_to_list_of_favorite_for_users(currenly_logged_user);

               debugPrint("Id of product-----"+widget.product.id);

               _productProvider.updateProduct(widget.product, widget.product.id);
               //save to firebase

               debugPrint("Sending notify to firebase 8213");
             }

           },
         );
    }

    return result
        ? IconButton(
            icon: Icon(Icons.favorite, size: 26, color: Colors.yellow),
            onPressed: () async {

              bool is_user_anonymyouse = _auth.currentUser.isAnonymous;

              if(is_user_anonymyouse) {
                showMyDialog(context, false, 'Log in',
                    'You are anonymouse user for now. You need to log in to add this product to favorites. You can do it in side menu in personal cabinet.', 'Okey');
              }
              else
              {

                debugPrint("Current user--"+_auth.currentUser.toString());
                debugPrint("Logged User---"+currenly_logged_user);
                widget.product.remove_item_from_list_of_favorite_for_users(currenly_logged_user);

                debugPrint("Id of product-----"+widget.product.id);

                _productProvider.updateProduct(widget.product, widget.product.id);
                //save to firebase


                debugPrint("Sending notify to firebase 8213");
              }

            },
          )
        : IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.grey, size: 26.0),
            onPressed: () {

              bool is_user_anonymyouse = _auth.currentUser.isAnonymous;

              if(is_user_anonymyouse) {
                showMyDialog(context, false, 'Log in',
                    'You are anonymouse user for now. You need to log in to add this product to favorites. You can do it in side menu in personal cabinet.', 'Okey');
              }
              else
              {

                debugPrint("Current user--"+_auth.currentUser.toString());
                debugPrint("Logged User---"+currenly_logged_user);
                widget.product.add_item_to_list_of_favorite_for_users(currenly_logged_user);

                debugPrint("Id of product-----"+widget.product.id);

                _productProvider.updateProduct(widget.product, widget.product.id);
                //save to firebase

                debugPrint("Sending notify to firebase 8213");
              }

            },
          );
  }


}
