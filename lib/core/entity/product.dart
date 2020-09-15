import 'dart:io';


class Product {

  String id;
  String image;
  String details;
  String name;
  String price;
  String old_price;
  String categorie;
  bool is_new;

  Product(this.image, this.details, this.name, this.price,
      this.old_price, this.categorie, this.is_new);

  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        details = snapshot['details'] ?? '',
        name = snapshot['name'] ?? '',
        old_price = snapshot['old_price'] ?? '',
        categorie = snapshot['categorie'] ?? '',
        is_new = snapshot['is_new'] ?? '',
        image = snapshot['img'] ?? '';


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
