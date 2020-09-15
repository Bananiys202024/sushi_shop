import 'package:flutter/material.dart';
import 'package:flutter_app/UI/trash/ModifyProduct.dart';
import 'package:flutter_app/core/models/product.dart';
import 'package:flutter_app/core/viewModels/CRUDModel.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails({@required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: <Widget>[

          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: ()async {
              await productProvider.removeProduct(product.id);
              Navigator.pop(context) ;
            },
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: (){


              Navigator.push(
                context,

              MaterialPageRoute(
                  builder: (context) => ModifyProduct(product: product,))
              );

            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: product.id,
            child: Image.asset(
              'assets/${product.image}.jpg',
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            product.name,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          Text(
            '${product.price} \$',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent),
          )
        ],
      ),
    );
  }
}