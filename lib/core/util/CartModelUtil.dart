import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/product.dart';

class CardModelUtil {
  final List<Product> _items = [];

  static bool check_if_list_already_contains_product(List<Product> _items,
      Product product) {

    if (_items == null) return false;

    String id = product.id;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) return true;
    }

    return false;
  }

  static int add_plus_one_to_quantity_of_that_item(List<Product> _items, Product product)
  {

    int count = 0;
    String id = product.id;

    debugPrint('length of list---'+_items.length.toString());

    for (int i = 0; i < _items.length; i++) {
      debugPrint("this is item_---"+_items[i].id);
      if (_items[i].id == id)
        {
            debugPrint(_items[i].id.toString());
            debugPrint(_items[i].quantity.toString());
            int quantity = _items[i].quantity;
            _items.remove(product);
            product.set_quantity = quantity+1;
            _items.add(product);
            debugPrint("SET_QUANTITY----"+product.quantity.toString());
            count++;
        };
    }

    return count;
  }

  static int minus_one_to_quantity_of_that_item(List<Product> _items, Product product)
  {

    int counter = 0;
    String id = product.id;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id)
      {
        debugPrint('Length'+_items.length.toString());
        debugPrint("id from items---"+_items[i].id.toString());
        debugPrint("just id----"+id.toString());
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

  static Product findByid(List<Product> _items, id)
  {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        return _items[i];
      }
    }
  }

}
