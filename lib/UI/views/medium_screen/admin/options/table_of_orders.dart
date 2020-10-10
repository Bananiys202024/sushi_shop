
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';

class TableOfOrders extends StatefulWidget {
  TableOfOrders({Key key}) : super(key: key);

  @override
  _TableOfOrdersState createState() => _TableOfOrdersState();
}

class _TableOfOrdersState extends State<TableOfOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimplifiedTopMenu(),
      body: get_body(),
    );
  }

  get_body()
  {
    return Center(
      child: Text("Table of Order"),
    );
  }
}