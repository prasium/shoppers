import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/providers/orders.dart';
import 'package:shoppers/screens/edit_product.dart';
import 'package:shoppers/screens/product_detail.dart';
import 'package:shoppers/screens/user_products.dart';
import './screens/products_overview.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // listen to change in child widgets which are listening
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // builder should return new instance of provided  class
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
            create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
            create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shoppers",
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.redAccent,
          fontFamily: 'Lato',
        ),
        home: ProductsOverview(),
        routes: {
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx)=>UserProductsScreen(),
          EditProduct.routeName: (ctx) => EditProduct(),
        },
      ),
    );
  }
}
