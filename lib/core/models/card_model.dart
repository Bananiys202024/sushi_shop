import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/core/util/CartModelUtil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'product.dart';

//model for cashe
class CardModel extends Model {
  final List<Product> _items = [];
  int counter = 0;
  String choosen_categorie = "sushi";

  List<Product> get_all() {
    return _items;
  }

  int get_counter() {
    return this.counter;
  }

  String get_choosen_categorie()
  {
    return choosen_categorie;
  }

  String set_choosen_categorie(String parameter)
  {
      this.choosen_categorie = parameter;
  }

  void add(Product product) {

    counter ++;

    bool is_list_contain =
        CardModelUtil.check_if_list_already_contains_product(_items, product);

    //extract that product from list of items
    //change quantity of that item
    if (is_list_contain)
      CardModelUtil.add_plus_one_to_quantity_of_that_item(_items, product);

    //new item, was not existing in list before
    if (!is_list_contain) {
      product.set_quantity = 1;
      _items.add(product);
    }

    debugPrint('lngth--'+_items.length.toString());
    notifyListeners();
  }

  void remove_by_id(String id) {

    int quantity = 0;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        quantity = _items[i].quantity;
        debugPrint("remove-id-----"+quantity.toString());
        _items.remove(_items[i]);
      }
    }

    counter = counter - quantity;

    debugPrint('ITEMS-----' + _items.toString());

    notifyListeners();
  }

  String get_quantity_by_id(id) {
    Product product = CardModelUtil.findByid(_items, id);
    return product.quantity.toString();
  }

  void minus_quantity(Product product) {
    debugPrint('from method minus quantity');

    int count = CardModelUtil.minus_one_to_quantity_of_that_item(_items, product);
    counter = counter - count;
  }

  void add_quantity(Product product) {
    debugPrint('from method add quantity');
    debugPrint("There is--"+counter.toString());

    debugPrint('');


    int count = CardModelUtil.add_plus_one_to_quantity_of_that_item(_items, product);
    counter = counter + count;
  }

  void removeAll() {
    debugPrint('before---' + _items.length.toString());
    _items.clear();
    debugPrint('after----' + _items.length.toString());
    counter = 0;
    notifyListeners();
  }
}
