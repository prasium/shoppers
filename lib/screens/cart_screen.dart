import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart' ;
import '../providers/orders.dart';


class CartScreen extends StatelessWidget {

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('₹${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: (){
                    Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                    );
                    cart.clear();
                  }, child: const Text(
                    "ORDER NOW",
                  ),),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: 
          ListView.builder(itemBuilder: (ctx, ind){
            return CartItem(
              id:cart.items.values.toList()[ind].id,
              productId: cart.items.keys.toList()[ind],
              price: cart.items.values.toList()[ind].price,
              quantity:cart.items.values.toList()[ind].quantity,
              title:cart.items.values.toList()[ind].title,
            );
          },
            itemCount: cart.items.length,
          ),
          ),
        ],
      ),
    );
  }
}
