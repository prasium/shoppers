import 'package:flutter/widgets.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    if(_items.containsKey(productId)) { //change quantity
      _items.update(productId, (existingCartItem) => CartItem(
          id:existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity+1,
          price: existingCartItem.price),
      );
    }
    else{
      _items.putIfAbsent(productId,()=> CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  int get itemCount{
    // quantity of item
    return _items==null?0:_items.length;
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void clear(){
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId)
  {
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity>1){
      _items.update(productId, (existingItem) => CartItem(
          id: existingItem.id, title: existingItem.title,
          quantity: existingItem.quantity-1, price: existingItem.price,)
      );
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
  }


}