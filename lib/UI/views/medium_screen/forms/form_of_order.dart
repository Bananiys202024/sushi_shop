import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';
import 'package:flutter_app/UI/widgets/fragments/forms/form_of_order.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';


class FormOfOrder extends StatefulWidget {
  FormOfOrder({Key key}) : super(key: key);

  @override
  _FormOfOrderState createState() => _FormOfOrderState();
}

class _FormOfOrderState extends State<FormOfOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimplifiedTopMenu(),
      body: get_body(),
    );
  }

  Widget get_body() {
    return ScopedModelDescendant<CardModel>(builder: (context, child, model) {
      return
        SingleChildScrollView (
        child:Container(
        margin: EdgeInsets.all(20.0),
        child: BodyFormOfOrder(model: model),
        ),
        );
    });
  }
}

