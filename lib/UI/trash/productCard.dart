import 'package:flutter/material.dart';
import 'package:flutter_app/UI/trash/productDetails.dart';
import 'package:flutter_app/core/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product productDetails;

  ProductCard({@required this.productDetails});

  @override
  Widget build(BuildContext context) {

    debugPrint('debug Print---'+ productDetails.image);

    return GestureDetector(
      onTap: (){


        Navigator.push(
          context,

        MaterialPageRoute(
            builder: (context) => ProductDetails(product: productDetails)),
        );



        },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.45,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: productDetails.id,
                  child:
//                  Image.network('https://googleflutter.com/sample_image.jpg'),

                  Image.network(productDetails.image,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height *
                        0.35,
                  ),

//                  Image.asset(
//                    'assets/${productDetails.image}.jpg',
//                    height: MediaQuery
//                        .of(context)
//                        .size
//                        .height *
//                        0.35,
//                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        productDetails.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        '${productDetails.price} \$',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}