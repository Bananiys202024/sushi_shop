import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'medium_screen/main.dart';


class MainBody extends StatefulWidget {
  MainBody({Key key, this.initIndex}) : super(key: key);

  int initIndex;

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return
      ScopedModelDescendant<CardModel>(
          builder: (context, child, model) {
            return Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth <= 300) {
                    return new Text('SMALL');
                  }
                  if (constraints.maxWidth > 300 &&
                      constraints.maxWidth <= 600) {
                    return MainMediumPhone(model: model, initIndex: widget.initIndex);
                  }
                  if (constraints.maxWidth > 600 &&
                      constraints.maxWidth <= 1000) {
                    return new Text("more of average size");
                  }
                  if (constraints.maxWidth > 1000) {
                    return new Text("BIG");
                  }
                },
              ),
            );
          },
    );
  }
}
