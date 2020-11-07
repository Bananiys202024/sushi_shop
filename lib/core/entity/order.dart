import 'dart:io';

import 'package:flutter_app/core/entity/product.dart';



class Order {

  String id;
  String name_of_client;
  List<Map<String, dynamic>> products; //this column for save data for column "products"
  List<dynamic> get_products;          //this column for get data for column "products"
  String phone_of_client;
  String comment;
  String time_of_order;
  String promo_code;

  String payment;
  String address;


  String status; //this column only for order table;
  int total_price; //this column only for order table;

  Order(this.name_of_client, this.products, this.promo_code
  , this.phone_of_client,  this.comment, this.address, this.time_of_order, this.total_price, this.payment);

  Order.fromMap(Map snapshot,String id) :
        id = id ?? '',
        name_of_client = snapshot['name_of_client'] ?? '',
        get_products = snapshot['products'] ?? '',
        phone_of_client = snapshot['phone_of_client'] ?? '',
        promo_code = snapshot['promo_code'] ?? '',
        comment = snapshot['comment'] ?? '',
        address = snapshot['address'] ?? '',
        time_of_order = snapshot['time_of_order'] ?? '',
        status = "Pending",
        total_price = snapshot['total_price'],
        payment = snapshot['payment'];


  toJson() {
    return {
      "name_of_client": name_of_client,
      "products": products,
      "phone_of_client": phone_of_client,
      "comment" : comment,
      "address": address,
      "time_of_order": time_of_order,
      "promo_code": promo_code,
      "total_price": total_price,
      "payment": payment,
    };
  }
}
