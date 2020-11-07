
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/drawer.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';

class AccountCabinet extends StatefulWidget {
  AccountCabinet({Key key}) : super(key: key);

  @override
  _AccountCabinetState createState() => _AccountCabinetState();
}

class _AccountCabinetState extends State<AccountCabinet> {

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    debugPrint("CurrentUser---"+auth.currentUser.toString());


    return Scaffold(
      appBar: SimplifiedTopMenu(),
      drawer: DrawerMenu(),
      body:
      Center(
        child: RaisedButton(
            color: Colors.grey,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              debugPrint("CurrentUser---"+auth.currentUser.toString());

              await print("result");
              await auth
                  .idTokenChanges()
                  .listen((User user) {
                if (user == null) {
                  print('by token User is currently signed out!');
                } else {
                  print('by token User is signed in!');
                }
              });
            },
            child: Text('Sign out'),
        ),
//      child: Text("Account cabinet"),

      ),
    );
  }
}