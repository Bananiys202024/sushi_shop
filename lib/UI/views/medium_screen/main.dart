import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/patterns/pattern_shop_list.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loader/loader.dart';

class MainMediumPhone extends StatefulWidget {
  MainMediumPhone({Key key, this.model, this.initIndex}) : super(key: key);

  List<Product> list_sushi = null;
  List<Product> list_pizza = null;
  List<Product> list_packs_and_combos = null;
  List<Product> list_rolls = null;
  CardModel model;
  int initIndex;
  List<Product> products;

  @override
  _MainMediumPhoneState createState() => _MainMediumPhoneState();
}

class _MainMediumPhoneState extends State<MainMediumPhone>
    with TickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
        child: Text(
      "sushi",
      style: TextStyle(fontSize: 18),
    )),
    Tab(
        child: Text(
      "pizza",
      style: TextStyle(fontSize: 18),
    )),
    Tab(
        child: Text(
      "packs and combos",
      style: TextStyle(fontSize: 18),
    )),
    Tab(
        child: Text(
      "rolls",
      style: TextStyle(fontSize: 18),
    )),
    Tab(
        child: Text(
      "favorites",
      style: TextStyle(fontSize: 18),
    )),
    Tab(
        child: Text(
      "new",
      style: TextStyle(fontSize: 18),
    )),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: widget.initIndex, vsync: this, length: 6);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModelForTableProducts>(context);

    debugPrint('inside');
    _tabController.addListener(() {
      debugPrint("Index inside---" + _tabController.index.toString());

      String choosen_categorie = '';

      if (_tabController.index == 0) choosen_categorie = 'sushi';

      if (_tabController.index == 1) choosen_categorie = 'pizza';

      if (_tabController.index == 2) choosen_categorie = 'packs and combos';

      if (_tabController.index == 3) choosen_categorie = 'roll';

      if (_tabController.index == 4) choosen_categorie = 'favorites';

      if (_tabController.index == 5) choosen_categorie = 'new';

      widget.model.set_choosen_categorie(choosen_categorie);

      debugPrint(
          "Check of categories----" + widget.model.get_choosen_categorie());
    });
      debugPrint("after listener inside main class;");

    return MaterialApp(
      home: StreamBuilder(
          stream: productProvider.fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              widget.products = snapshot.data.documents
                  .map((doc) => Product.fromMap(doc.data(), doc.documentID))
                  .toList();

              return DefaultTabController(
                length: 6,
                child: Scaffold(
                  appBar: new PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: myTabs,
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      PatternShopList(
                          products: widget.products
                              .where((x) =>
                                  x.categorie.toLowerCase().contains("sushi"))
                              .toList()),

                      PatternShopList(
                          products: widget.products
                              .where((x) =>
                                  x.categorie.toLowerCase().contains("pizza"))
                              .toList()),

                      PatternShopList(
                          products: widget.products
                              .where((x) => x.categorie
                                  .toLowerCase()
                                  .contains("packs_and_combos"))
                              .toList()),

                      PatternShopList(
                          products: widget.products
                              .where((x) =>
                                  x.categorie.toLowerCase().contains("roll"))
                              .toList()),

                      //favorite categorie
                      PatternShopList(products: null),

                      //new categorie
                      PatternShopList(
            products:widget.products
                .where((x) =>
            x.is_new == true)
                .toList()),


//                      PatternShopList(products: widget.products),
//                      PatternShopList(products: widget.products),
//                      PatternShopList(products: widget.list_rolls),
//                      PatternShopList(products: null),
//                      PatternShopList(products: null),
//                      PatternShopList(products: widget.list_sushi),
//                      PatternShopList(products: widget.list_pizza),
//                      PatternShopList(products: widget.list_packs_and_combos),
//                      PatternShopList(products: widget.list_rolls),
//                      PatternShopList(products: null),
//                      PatternShopList(products: null),
                    ],
                  ),
                ),
              );
            }
            else {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: 1,
                      child: CircularProgressIndicator(backgroundColor: Colors.red,),
                    )
                  ],
                ),
              ),
            );
            }
          }),
    );
  }


} //end class
