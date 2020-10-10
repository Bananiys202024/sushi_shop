import 'package:flutter/material.dart';
import 'package:flutter_app/core/entity/product.dart';

class CardModelUtil {
  final List<Product> _items = [];

  static bool check_if_list_already_contains_product(List<Product> _items,
      Product product) {

    if (_items == null) return false;

    String name = product.name;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].name == name) return true;
    }

    return false;
  }

  static int add_plus_one_to_quantity_of_that_item(List<Product> _items, Product product)
  {

    int count = 0;
    String name = product.name;

    debugPrint('length of list---'+_items.length.toString());


    for (int i = 0; i < _items.length; i++) {
      debugPrint("this is item_---"+_items[i].name);
      debugPrint('inside loop length of list---'+_items.length.toString());
      if (_items[i].name == name)
        {
            debugPrint(_items[i].name.toString());
            debugPrint(_items[i].quantity.toString());
            int quantity = _items[i].quantity;

            product.set_quantity = quantity+1;
            _items[i] = product;
            debugPrint("SET_QUANTITY----"+product.quantity.toString());
            count++;
        };
    }
    debugPrint('inside loop length of list---'+_items.length.toString());

    debugPrint('finish in method add_pus_one_to...');

    return count;
  }

  static int minus_one_to_quantity_of_that_item(List<Product> _items, Product product)
  {

    int counter = 0;
    String name = product.name;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].name == name)
      {
        debugPrint('Length'+_items.length.toString());
        debugPrint("id from items---"+_items[i].name.toString());
        debugPrint("just id----"+name.toString());
        debugPrint(_items[i].quantity.toString());
        int quantity = _items[i].quantity;
        product.set_quantity = quantity-1;

        if(quantity <= 0)
        product.set_quantity = 0;

        counter++;

        _items.remove(product);
        _items.add(product);
        debugPrint("SET_QUANTITY----"+product.quantity.toString());
      };
    }

    return counter;
  }

  static Product findByName(List<Product> _items, name)
  {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].name == name) {
        return _items[i];
      }
    }
  }

}
