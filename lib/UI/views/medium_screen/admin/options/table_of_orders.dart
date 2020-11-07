import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';
import 'package:flutter_app/core/entity/order.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableOrders.dart';
import 'package:provider/provider.dart';

class TableOfOrders extends StatefulWidget {
  TableOfOrders({Key key}) : super(key: key);

  List<Order> orders_list;

  @override
  _TableOfOrdersState createState() => _TableOfOrdersState();
}

class _TableOfOrdersState extends State<TableOfOrders> {

  List<String> options =  <String>['Pending', 'Accepted', 'Courier on way', 'Cancelled'];
  String dropdownValue = 'Cancelled';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimplifiedTopMenu(),
      body: get_body(),
    );
  }

  get_body() {
    final productProvider = Provider.of<CRUDModelForTableOrders>(context);

    return StreamBuilder(
        stream: productProvider.fetchProductsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            widget.orders_list = snapshot.data.documents
                .map((doc) => Order.fromMap(doc.data(), doc.documentID))
                .toList();

            debugPrint("List---" + widget.orders_list[0].toString());

            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(children: [
                    Text('Phone'),
                    Text('Status'),
                    Text('Address'),
                    Text('Payment'),
                    Text('Time'),
                    Text('Price'),
                    Text('Details'),
                  ]),

                  for (var order in widget.orders_list)
                    TableRow(children: [

                      Text(order.phone_of_client),



                    Container(
    alignment: Alignment.center,
    color: Colors.blue,
    child: DropdownButton<String>(
    value: dropdownValue,
    onChanged: (String newValue) {
    setState(() {
    dropdownValue = newValue;
    });
    },
    style: TextStyle(color: Colors.blue),
    selectedItemBuilder: (BuildContext context) {
    return options.map((String value) {
    return Text(
    dropdownValue,
    style: TextStyle(color: Colors.white),
    );
    }).toList();
    },
    items: options.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList(),
    ),
    ),


//          Container(
//          alignment: Alignment.center,
//          color: Colors.blue,
//                      child: new DropdownButton<String>(
//
//                        items: <String>[order.status, 'Pending', 'Accepted', 'Courier on way', 'Cancelled'].map((String value) {
//                          return new DropdownMenuItem<String>(
//
//                            value: value,
//                            child: new Text(value,   style: TextStyle(color: Colors.black)),
//                          );
//                        }).toList(),
//                        onChanged: (_) {},
//                      ),
//          ),
                      Text(order.address),
                      Text(order.payment),

                      Text(order.time_of_order),
                      Text(order.total_price.toString()),
                      RaisedButton(
                        onPressed: () => {
                          _show_details_dialog(order.get_products, order.comment),
                        },
                        child: new Text('Details'),
                      ),
                    ])
//          for(int i=0;i<10;i++)
//            {
//              TableRow(children: [
//                Text('+380977784557'),
//                Text('Accepted'),
//                Text('so fast as possible'),
//                Text('1145p'),
//                Text('show details'),
//              ]),
//            }
                ],
              ),
            );
          } else {
            return Center(
              child: Text("No ordered items"),
            );
          }
        });
  }

  Future<void> _show_details_dialog(List<dynamic> ordered_products, String comment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ordered items'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Table(
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    for (Map<String, dynamic> product in ordered_products)
                      TableRow(children: [
                        Text('Name: ' + product.values.toList()[4].toString()),
                        Text('Price: ' + product.values.toList()[1].toString()),
                        Text('Comment: ' + comment),

                      ])
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
