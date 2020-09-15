import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_app/UI/views/main.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/viewModels/CRUDModel.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import './locator.dart';


void main() {

  setupLocator();

  runApp(
    DevicePreview(
        builder: (context) => MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  CardModel cardModel = CardModel();

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
    ],
    child:
    ScopedModel<CardModel>(
      model: cardModel,
      child:
        new WillPopScope(
        onWillPop: () async => false,
    child: MaterialApp(
        locale: DevicePreview.of(context).locale, // <--- Add the locale
        builder: DevicePreview.appBuilder, // <--- Add the builder
        home: MainPage(initIndex: 0),
      ),
     ),
    ),
    );
  }
}
