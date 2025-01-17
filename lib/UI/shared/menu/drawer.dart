import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/views/main.dart';
import 'package:flutter_app/UI/views/medium_screen/account/cabinet.dart';
import 'package:flutter_app/UI/views/medium_screen/account/input_phone_number_and_confirm_by_input_code.dart';
import 'package:flutter_app/UI/views/medium_screen/admin/admin_page.dart';
import 'package:flutter_app/core/models/Constants.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  double size_of_icon = 30.0;
  double size_of_head_text = 17.0;
  double size_of_subtitle = 13.0;
  var images = Constants.get_categories();
  bool _isVisible_admin_panel =
      FirebaseAuth.instance.currentUser == null ?
          false:
      FirebaseAuth.instance.currentUser.phoneNumber.toString().toLowerCase() == "+380742847338";

  bool _isVisible_log_out_button =
  FirebaseAuth.instance.currentUser == null ?
      false:
  !(FirebaseAuth.instance.currentUser.isAnonymous);
  //check if anonymouse user equals to anonymouse;

  bool is_any_user_logged_in =  FirebaseAuth.instance.currentUser == null ?
  false:
  FirebaseAuth.instance.currentUser.isAnonymous;

  @override
  Widget build(BuildContext context) {
    debugPrint("From drawer---");

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputPhoneNumber()));
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: size_of_icon,
                      color: Color.fromRGBO(220, 10, 0, 1),
                    )),
              ),
              InkWell(
                onTap: () {


                  if(is_any_user_logged_in )
                    {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountCabinet()));


                    }
                  else
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InputPhoneNumber()));

                    }



                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal cabinet',
                        style: TextStyle(
                            color: Colors.black, fontSize: size_of_head_text)),
                    Text(
                      'To accumulate bonuses',
                      style: TextStyle(
                          color: Colors.grey, fontSize: size_of_subtitle),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage()));
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: size_of_icon,
                      color: Color.fromRGBO(220, 10, 0, 1),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(initIndex: 0,)));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Products',
                        style: TextStyle(
                            color: Colors.black, fontSize: size_of_head_text)),
                    Text(
                      'show all products',
                      style: TextStyle(
                          color: Colors.grey, fontSize: size_of_subtitle),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Divider(height: 1),
          Divider(),
          ScopedModelDescendant<CardModel>(
            builder: (context, child, model) {
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.only(left: 20, right: 20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                childAspectRatio: 0.77,
                children: <Widget>[
                  for (int i = 0; i < images.length; i++)
                    create_categorie_for_drawer_side_menu(images[i], model),
                ],
              );
            },
          ),
          Divider(height: 1),
          Divider(),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.phone,
                    size: size_of_icon,
                    color: Color.fromRGBO(220, 10, 0, 1),
                  )),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('+0543384556',
                      style: TextStyle(
                          color: Colors.black, fontSize: size_of_head_text)),
                  Text(
                    'phone of restaurant',
                    style: TextStyle(
                        color: Colors.grey, fontSize: size_of_subtitle),
                  ),
                ],
              ),
            ],
          ),




          Visibility (
            visible: _isVisible_log_out_button,
            child:
            InkWell(
              onTap: () {
                debugPrint('started');
                FirebaseAuth.instance.signOut();
                setState(() {

                  _isVisible_admin_panel = false;
                  _isVisible_log_out_button = false;

                });
                debugPrint("log out");
              },
              child:
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.admin_panel_settings,
                        size: size_of_icon,
                        color: Color.fromRGBO(220, 10, 0, 1),
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Log out',
                          style: TextStyle(
                              color: Colors.black, fontSize: size_of_head_text)),
                      Text(
                        'log out',
                        style: TextStyle(
                            color: Colors.grey, fontSize: size_of_subtitle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


    Visibility (
    visible: _isVisible_admin_panel,
    child:
    InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => AdminPage()));
    },
    child:
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.admin_panel_settings,
                    size: size_of_icon,
                    color: Color.fromRGBO(220, 10, 0, 1),
                  )),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Admin panel',
                      style: TextStyle(
                          color: Colors.black, fontSize: size_of_head_text)),
                  Text(
                    'customization of app',
                    style: TextStyle(
                        color: Colors.grey, fontSize: size_of_subtitle),
                  ),
                ],
              ),
            ],
          ),
    ),
    ),

        ],
      ),
    );
  }

  Widget create_categorie_for_drawer_side_menu(
      String name_of_image, CardModel model) {
    return InkWell(
      onTap: () {
        if (name_of_image == 'sushi') {
          model.set_choosen_categorie('sushi');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPage(initIndex: 0)));
        }

        if (name_of_image == 'pizza') {
          model.set_choosen_categorie('pizza');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPage(initIndex: 1)));
        }

        if (name_of_image == 'packs and combos') {
          model.set_choosen_categorie('packs and combos');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPage(initIndex: 2)));
        }

        if (name_of_image == 'roll') {
          model.set_choosen_categorie('roll');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPage(initIndex: 3)));
        }

        if (name_of_image == 'favorites') {
          model.set_choosen_categorie('favorites');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPage(initIndex: 4)));
        }

        if (name_of_image == 'new') {
          model.set_choosen_categorie('new');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPage(initIndex: 5)));
        }
      },
      child: new Column(
        children: [
          Container(
            width: 50.0,
            height: 60.0,
            child: Image.asset(
                "assets/images/categories/" + name_of_image + '.png'),
          ),
          Text(
            name_of_image,
            style: TextStyle(
              color: model.choosen_categorie == name_of_image
                  ? Colors.green
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
