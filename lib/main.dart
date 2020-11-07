import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_app/UI/views/main.dart';
import 'package:flutter_app/UI/views/medium_screen/account/cabinet.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableOrders.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableProducts.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import './locator.dart';


void main() async{

  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
    anonymouse_authetication();

    return
      MultiProvider(
        providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModelForTableProducts>()),
        ChangeNotifierProvider(builder: (_) => locator<CRUDModelForTableOrders>()),
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
        routes: <String, WidgetBuilder> {
          '/catalog_page': (BuildContext context) => new MainPage(initIndex: 0),
          '/cabinet': (BuildContext context) => new AccountCabinet(),
        }
       ),
      ),
     ),
    );
  }


  void anonymouse_authetication() async
  {
    debugPrint('try authetication');
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInAnonymously();
      debugPrint("UserCredentials----" + userCredential.toString());
      debugPrint("CurrentUser---" + auth.currentUser.toString());
    }catch(e)
    {
      debugPrint("Error!!"+e);
    }
  }
}
