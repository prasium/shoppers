import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppers/helpers/custom_route.dart';
import 'package:shoppers/providers/auth.dart';
import 'package:shoppers/providers/orders.dart';
import 'package:shoppers/screens/auth_screen.dart';
import 'package:shoppers/screens/edit_product.dart';
import 'package:shoppers/screens/product_detail.dart';
import 'package:shoppers/screens/products_overview.dart';
import 'package:shoppers/screens/splash_screen.dart';
import 'package:shoppers/screens/user_products.dart';

import './providers/cart.dart';
import './providers/products_provider.dart';
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
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          // builder should return new instance of provided  class
          update: (ctx, auth, previousProducts) => ProductsProvider(auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
          create: (ctx) => ProductsProvider(null,null, []),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth,previousOrders)=> Orders(auth.token,auth.userId, previousOrders==null?[]:previousOrders.orders),
          create: (ctx) => Orders(null,null,[]),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shoppers",
          theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.redAccent,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              }
            ),
          ),
          home: authData.isAuth ? ProductsOverview() : FutureBuilder(
              future: authData.tryAutoLogin(),
              builder: (ctx, authResultSnapshot)=> authResultSnapshot.connectionState==ConnectionState.waiting?
              SplashScreen(): AuthScreen(),
          ),
          routes: {
            ProductDetail.routeName: (ctx) => ProductDetail(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProduct.routeName: (ctx) => EditProduct(),
          },
        ),
      ),
    );
  }
}
