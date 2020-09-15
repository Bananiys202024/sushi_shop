import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/drawer.dart';
import 'package:flutter_app/UI/shared/menu/top_menu.dart';

import 'main_body.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.initIndex}) : super(key: key);

  int initIndex;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopMenu(),
      drawer: DrawerMenu(),
      body: MainBody(initIndex: widget.initIndex),
    );
  }
}
