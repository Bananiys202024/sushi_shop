import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_app/UI/views/medium_screen/shop_bucket.dart';
import 'package:flutter_app/core/models/Constants.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class TopMenu extends StatefulWidget implements PreferredSizeWidget {
  TopMenu({Key key}) : super(key: key);

  final String title = Constants.get_title_of_top_menu();

  @override
  _TopMenuState createState() => _TopMenuState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _TopMenuState extends State<TopMenu> {
  Widget get_top_menu() {
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.red),
      backgroundColor: Color(0xFFf7f7f7),
      title: get_title(),
      actions: get_actions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return get_top_menu();
  }

  go_to_shop_card() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopCard()))
        .then((value) => setState(() {}));
  }

  get_title() {
    return Row(
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
    );
  }

  get_actions() {
    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.search, color: Colors.red),
      ),
      ScopedModelDescendant<CardModel>(
        builder: (context, child, model) {
          return Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Badge(
                showBadge: !(model.counter == 0),
                badgeContent: Text(model.get_counter().toString()),
                position: BadgePosition.topLeft(),
                child: IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () => go_to_shop_card(),
                    color: Colors.red),
              ));
        },
      ),
    ];
  }
}
