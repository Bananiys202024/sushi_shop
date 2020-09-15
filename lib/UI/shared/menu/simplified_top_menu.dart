import 'package:flutter/material.dart';
import 'package:flutter_app/UI/views/medium_screen/shop_bucket.dart';
import 'package:flutter_app/core/models/Constants.dart';

class SimplifiedTopMenu extends StatefulWidget implements PreferredSizeWidget {
  SimplifiedTopMenu({Key key}) : super(key: key);

  final String title = Constants.get_title_of_top_menu();

  @override
  _SimplifiedTopMenuState createState() => _SimplifiedTopMenuState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _SimplifiedTopMenuState extends State<SimplifiedTopMenu> {
  Widget get_top_menu() {
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.red),
      backgroundColor: Color(0xFFf7f7f7),
      title: Row(
        children: <Widget>[
          Image(
            width: 50,
            height: 40,
            image: AssetImage('assets/images/external_icons/logo.png'),
          ),
          Text(
            widget.title,
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return get_top_menu();
  }

  go_to_shop_card() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShopCard()),
    );
  }
}
