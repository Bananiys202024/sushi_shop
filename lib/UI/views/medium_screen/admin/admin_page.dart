import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';
import 'package:flutter_app/UI/trash/HomeView.dart';
import 'package:flutter_app/UI/views/medium_screen/admin/options/table_of_orders.dart';

import 'options/create_new_product.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimplifiedTopMenu(),
      body: get_body(),
    );
  }

  Widget get_body() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateNewProduct()));
          },
          child: Container(
            height: 50,
            color: Colors.red[600],
            child: const Center(
                child: Text('Add new product',
                    style: TextStyle(color: Colors.white))),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeView()));
          },
          child: Container(
            height: 50,
            color: Colors.red[600],
            child: const Center(
                child: Text('Add new product',
                    style: TextStyle(color: Colors.white))),
          ),
        ),
        Container(
          height: 50,
          color: Colors.red[500],
          child: const Center(
              child: Text('Remove product by name',
                  style: TextStyle(color: Colors.white))),
        ),

    InkWell(
    onTap: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => TableOfOrders()));
    },
    child:Container(
          height: 50,
          color: Colors.red[600],
          child: const Center(
              child: Text('Table of orders',
                  style: TextStyle(color: Colors.white))),
        ),
    ),
      ],
    );
  }
}
