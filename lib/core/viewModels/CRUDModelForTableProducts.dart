import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/entity/product.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/services/api_for_table_products.dart';
import 'package:flutter_app/locator.dart';

class CRUDModelForTableProducts extends ChangeNotifier {
  ApiForTableProducts _api = locator<ApiForTableProducts>();

  List<Product> products;

  Future<List<Product>> fetchProducts() async {
    var result = await _api.getDataCollection();
    products = result.documents
        .map((doc) => Product.fromMap(doc.data(), doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Product> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Product.fromMap(doc.data(), doc.documentID);
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Product data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Product data) async{
    debugPrint("DATA___"+data.toString());
    var result  = await _api.addDocument(data.toJson()) ;
    return ;
  }
}