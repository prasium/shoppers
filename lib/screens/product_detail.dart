import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  //
  // ProductDetail(this.title);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen:
          false, // build method of widget wont rerun, whenever the product object is changed, done when we need only data one time
    ).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title,
                style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow( // bottomLeft
                          offset: Offset(-0.5, -0.5),
                          color: Colors.black
                      ),
                      Shadow( // bottomRight
                          offset: Offset(0.5, -0.5),
                          color: Colors.black
                      ),
                      Shadow( // topRight
                          offset: Offset(0.5, 0.5),
                          color: Colors.black
                      ),
                      Shadow( // topLeft
                          offset: Offset(-0.5, 0.5),
                          color: Colors.black
                      ),
                    ]
                ),
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '₹${loadedProduct.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    loadedProduct.description,
                    style: TextStyle(
                      fontSize: 18,

                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
