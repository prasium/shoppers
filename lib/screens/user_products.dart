import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext  context) async{
   await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProduct.routeName);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()=>_refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    UserProductItem(
                        productsData.items[i].id,
                        productsData.items[i].title,
                        productsData.items[i].imageUrl),
                 Divider(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
