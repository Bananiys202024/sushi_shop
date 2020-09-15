import 'package:flutter/material.dart';
import 'package:flutter_app/UI/views/medium_screen/forms/form_of_order.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({Key key, this.model}) : super(key: key);

  CardModel model;
  final String title = "atomic sushi";

  @override
  _BottomMenuState createState() => _BottomMenuState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Order'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delete),
          title: Text('remove all'),
        ),
      ],
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      if (widget.model.get_all().length == 0) {
        _showMyDialog(context);
      } else {
        _go_to_form_of_order(context);
      }
    }

    if (index == 1) remove_list_of_items_from_cashe(context);
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Empty Bucket',
              style: TextStyle(fontSize: 20, color: Colors.black)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your shop bucket is empty...',
                    style: TextStyle(fontSize: 20, color: Colors.black)
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  'Okey',
                   style: TextStyle(fontSize: 20, color: Colors.black)
                ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _go_to_form_of_order(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormOfOrder()),
    );
  }

  void remove_list_of_items_from_cashe(context) {
    context.widget.model.removeAll();
  }
}
