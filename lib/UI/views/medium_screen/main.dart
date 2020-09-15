import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/patterns/pattern_shop_list.dart';
import 'package:flutter_app/core/models/Generator.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class MainMediumPhone extends StatefulWidget {
  MainMediumPhone({Key key, this.model, this.initIndex}) : super(key: key);

  List<Product> list_sushi = Generator.list_sushi;
  List<Product> list_pizza = Generator.list_pizza;
  List<Product> list_packs_and_combos = Generator.list_packs_and_combos;
  List<Product> list_rolls = Generator.list_rolls;
  CardModel model;
  int initIndex;

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
    _tabController = TabController(initialIndex: widget.initIndex, vsync: this, length: 6);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        debugPrint('inside');
        _tabController.addListener(() {
          debugPrint("Index inside---" + _tabController.index.toString());

          String choosen_categorie = '';

          if (_tabController.index == 0)
            choosen_categorie = 'sushi';

          if (_tabController.index == 1)
            choosen_categorie = 'pizza';

          if (_tabController.index == 2)
            choosen_categorie = 'packs and combos';

          if (_tabController.index == 3)
            choosen_categorie = 'roll';

          if (_tabController.index == 4)
            choosen_categorie = 'favorites';

          if (_tabController.index == 5)
            choosen_categorie = 'new';

          widget.model.set_choosen_categorie(choosen_categorie);

          debugPrint("Check of categories----"+widget.model.get_choosen_categorie());
        });

    return MaterialApp(
      home: DefaultTabController(
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
              PatternShopList(products: widget.list_sushi),
              PatternShopList(products: widget.list_pizza),
              PatternShopList(products: widget.list_packs_and_combos),
              PatternShopList(products: widget.list_rolls),
              PatternShopList(products: null),
              PatternShopList(products: null),
            ],
          ),
        ),
      ),
    );
  }
} //end class
