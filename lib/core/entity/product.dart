import 'dart:io';


class Product {

  String id;
  String image;
  String details;
  String name;
  int price;
  int old_price;

  String categorie;
  bool is_new;

  int quantity;// we use this column to count quantity of ordered items,
  //this variable for page shop_bucket;
  bool is_favorite;//we don't use this column in entity 1


  Product(this.image, this.details, this.name, this.price,
      this.old_price, this.categorie, this.is_new);

  Product.asModel(this.id, this.image, this.name,  this.details, this.price,
      this.old_price, this.is_favorite, this.is_new, this.quantity);


  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        details = snapshot['details'] ?? '',
        name = snapshot['name'] ?? '',
        old_price = snapshot['old_price'] ?? '',
        categorie = snapshot['categorie'] ?? '',
        is_new = snapshot['is_new'] ?? '',
        image = snapshot['img'] ?? '';

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
    };
  }
}
