import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';


class Product {

  String id;
  String image;
  String details;
  String name;
  List<String> searchKeywords;
  int price;
  int old_price;
  String categorie;
  bool is_new;

  List<dynamic> favorite_for_users; //it is just list of users who like this product as favorite one;

  int quantity;// we use this column to count quantity of ordered items,
  //this variable for page shop_bucket;
  List<String> is_favorite;//we don't use this column in entity 1

  Product(this.image, this.details, this.name, this.price,
      this.old_price, this.categorie, this.is_new);

  Product.createNewProduct(this.image, this.details, this.name, this.price,
      this.old_price, this.categorie, this.is_new, this.searchKeywords, this.favorite_for_users);

  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        details = snapshot['details'] ?? '',
        name = snapshot['name'] ?? '',
        old_price = snapshot['old_price'] ?? '',
        categorie = snapshot['categorie'] ?? '',
        is_new = snapshot['is_new'] ?? '',
        image = snapshot['image'] ?? '',
        favorite_for_users = snapshot['favorite_for_users'];



  void add_item_to_list_of_favorite_for_users(String phone)
  {
    if(favorite_for_users == null)
      {
        favorite_for_users = [phone];
      }
    else
      {
        favorite_for_users.add(phone);
      }

  }

  void set set_quantity(int new_quantity) {
    this.quantity = new_quantity;
  }
//
//  toJsonAsString()
//  {
//    return "price"
//  }


  toJson() {
    return {
      "price": price,
      "old_price": old_price,
      "details" : details,
      "categorie" : categorie,
      "is_new" : is_new,
      "name": name,
      "image": image,
      "searchKeywords" : searchKeywords,
      "favorite_for_users": favorite_for_users,
    };
  }

  void remove_item_from_list_of_favorite_for_users(String currenly_logged_user)
  {
      if(favorite_for_users == null){}
      else{
        favorite_for_users.remove(currenly_logged_user);
      }
  }

}
