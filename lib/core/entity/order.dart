import 'dart:io';

import 'package:flutter_app/core/entity/product.dart';



class Order {

  String id;
  String name_of_client;
  List<Map<String, dynamic>> product; // actually list of objects in json;l
  String phone_of_client;
  String comment;
  String address;
  String time_of_order;
  String promo_code;

  Order(this.name_of_client, this.product, this.promo_code
  , this.phone_of_client,  this.comment, this.address, this.time_of_order);

  Order.fromMap(Map snapshot,String id) :
        id = id ?? '',
        name_of_client = snapshot['name_of_client'] ?? '',
        product = snapshot['product'] ?? '',
        phone_of_client = snapshot['phone_of_client'] ?? '',
        promo_code = snapshot['promo_code'] ?? '',
        comment = snapshot['comment'] ?? '',
        address = snapshot['address'] ?? '',
        time_of_order = snapshot['time_of_order'] ?? '';


  toJson() {
    return {
      "name_of_client": name_of_client,
      "products": product,
      "phone_of_client": phone_of_client,
      "comment" : comment,
      "address": address,
      "time_of_order": time_of_order,
      "promo_code": promo_code,
    };
  }
}
