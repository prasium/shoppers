import 'package:flutter/material.dart';
import 'package:shoppers/providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../screens/cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
  //  Provider.of<ProductsProvider>(context).fetchAndSetProducts();
  //   Future.delayed(Duration.zero).then((_) {
  //     Provider.of<ProductsProvider>(context).fetchAndSetProducts();
  //   });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isInit)
      {
        setState(() {
          _isLoading = true;
        });
        Provider.of<ProductsProvider>(context).fetchAndSetProducts()
        .then((_) {
          setState(() {
            _isLoading=false;
          });
        });
      }
    _isInit=false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoppers"),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) =>
              [
                PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: FilterOptions.All,
                ),
              ]
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
            builder: (_, cartData, ch) =>
                Badge(
                  child:ch,
                  value: cartData.itemCount.toString(),
                ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading? Center(child: CircularProgressIndicator(),):new ProductsGrid(_showOnlyFavorites),
    );
  }
}
