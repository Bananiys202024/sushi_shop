import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/entity/order.dart';
import 'package:flutter_app/core/services/api_for_table_orders.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/locator.dart';

class CRUDModelForTableOrders extends ChangeNotifier {
  ApiForTableOrders _api = locator<ApiForTableOrders>();

  List<Order> orders;

  Future<List<Order>> fetchProducts() async {
    var result = await _api.getDataCollection();
    orders = result.documents
        .map((doc) => Order.fromMap(doc.data(), doc.documentID))
        .toList();
    return orders;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Order> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Order.fromMap(doc.data(), doc.documentID);
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Order data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Order data) async{
    debugPrint("from add product method__");
    var result  = await _api.addDocument(data.toJson()) ;
    debugPrint("end add product method");
    return ;
  }
}

