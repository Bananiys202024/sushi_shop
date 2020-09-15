class Product {

  String id;
  String image;
  String details;
  String name;
  String price;
  String old_price;
  bool is_favorite;
  bool is_new;
  int quantity;// we use this column to count quantity of ordered items,
               //this variable for page shop_bucket;

  Product(this.id, this.image, this.name,  this.details, this.price,
      this.old_price, this.is_favorite, this.is_new, this.quantity);

  Product.CreateNewProduct(this.name, this.details, this.image,
                           this.price, this.old_price, this.is_favorite,
                           this.is_new, this.quantity);

  Product.forDebug(this.name, this.price, this.image);

  void set set_quantity(int new_quantity) {
    this.quantity = new_quantity;
  }


  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        image = snapshot['img'] ?? '';

  toJson() {
    return {
      "price": price,
      "name": name,
      "img": image,
    };
  }
}
