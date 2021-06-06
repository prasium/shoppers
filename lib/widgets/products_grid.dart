import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFav;

  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
  final productsData = Provider.of<ProductsProvider>(context);
  final products = showFav? productsData.favItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, item) => ChangeNotifierProvider.value(
        // . value approach use in List or Grid views because provider is attached with data
        value: products[item],
        child: ProductItem(
          // products[item].id,
          // products[item].title,
          // products[item].imageUrl,
    ),
      ),
    );
  }
}
