import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppers/models/http_exception.dart';
import './product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
//     Product(
//       id: 'p1',
//       title: 'Color Block T-Shirt',
//       description: 'Men Hooded Neck Multicolor ',
//       price: 349,
//       imageUrl:
//           'https://rukminim1.flixcart.com/image/714/857/kkec4280/t-shirt/b/m/i/l-t345-blwhrd-new-eyebogler-original-imafzr4f7nxecr44.jpeg?q=50',
//     ),
//     Product(
//       id: 'p2',
//       title: 'POCO X3 Pro',
//       description:
//           'For fast computing on the move, impressive photos, and all-day-long, uninterrupted performance, the POCO X3 Pro is the right device for you. This smartphone features the Qualcomm Snapdragon 860 for smooth function, 16.94-cm (6.67) FHD+ Display for clear visuals, and a 5160 mAh Battery to ensure that your smartphone does not run out of battery quickly. ',
//       price: 18999,
//       imageUrl:
//           'https://rukminim1.flixcart.com/image/832/832/kmthz0w0/mobile/j/c/p/x3-pro-mzb08ifin-poco-original-imagfn94amkm8wg3.jpeg?q=70',
//     ),
//     Product(
//       id: 'p3',
//       title: 'Ceramic Coffee Mug',
//       description:
//           'DSB\'s mug is made up of premium quality ceramic material which can be used in microwave and dishwasher safe. The print on the mug is permanent and fade-proof. Begin your day with a sip of your favorite beverage in the elegant and stylish range of DSB’s mug. This mug can be used to put in microwave. The product is delivered to you in safe and attractive packaging. This mug is highly suitable for gifting purpose. So gift it your loved ones and be ready to steal all the attention! This is absolutely great showpiece for any space. The mug holds 330 ml and can be used for drinking coffee, tea or milk.',
//       price: 179,
//       imageUrl:
//           'https://rukminim1.flixcart.com/image/832/832/kngd0nk0/mug/j/v/n/motivational-energy-quotes-inspiration-printed-white-inner-original-imag24z4xzthcv4b.jpeg?q=70',
//     ),
//     Product(
//       id: 'p4',
//       title: 'ALCHEMIST',
//       description:
//           'Santiago, an Andalusian shepherd boy, looks to travel the world in the quest to find a worldly treasure, unlike any others. Santiago’s quest takes him to the magical desert of Egypt, where he meets the alchemist. Is the alchemist what Santiago was looking for, or is he there to stop Santiago from fulfilling his quest? Well, you’ll have to read The Alchemist to find out. ',
//       price: 228,
//       imageUrl:
//           'https://rukminim1.flixcart.com/image/832/832/kjhgzgw0-0/book/m/m/u/alchemist-original-imafzfhzefg8etxh.jpeg?q=70',
//     ),
//     Product(
//         id: 'p5',
//         title: '3D Printed Bedsheet',
//         description:
//             'Enhance your bedroom interior with this exclusive bedsheet. Styled with an enthralling design and pattern, it will flaunt the rich taste in your bed linen collection. This is multicolored double bed sheet made from microfiber along with 2 matching pillow covers which further add grace to your bedroom. You can simply wash it by hand wash or machine wash and make sure on its first use wash it separately.',
//         price: 315,
//         imageUrl:
//             'https://rukminim1.flixcart.com/image/832/832/k6jnfrk0/bedsheet/7/p/e/blue-110010-flat-sam-creations-original-imafg3fkpxdvfu5t.jpeg?q=70'),
//     Product(
//         id: 'p6',
//         title: 'Cadbury Oreo Chocolatey Sandwich',
//         description:
//             'This pack contains 3 Cadbury Oreo vanilla crème biscuit family pack, 300g, each family pack includes 3 delicious vanilla flavor Oreo each of 100g ',
//         price: 56,
//         imageUrl:
//         'https://images-na.ssl-images-amazon.com/images/I/71IXYPKKFIL._SL1500_.jpg',
//     ),
//     Product(
//         id: 'p7',
//         title: 'Lifebuoy Antibacterial Germ Kill Sanitizer Spray',
//         description:
//             'Instant Germ Kill Spray that kills 99.9% bacteria and viruses (as per lab test on representative organism) ',
//         price: 90,
//         imageUrl:
// 'https://images-na.ssl-images-amazon.com/images/I/51-2ILFH01L._SL1000_.jpg'
//         ,),
//         Product(
//       id: 'p8',
//       title: 'Maggi - 560g',
//       description:
//       ' maggi2-Minute Masala Noodles is an instant noodles brand manufactured by Nestle. Made with the finest quality spices and ingredients. Number of Servings : About 8 ',
//       price: 78,
//       imageUrl:
// 'https://images-na.ssl-images-amazon.com/images/I/81tiRzUBKEL._SL1500_.jpg'    ),
//     Product(
//       id: 'p9',
//       title: 'Faber-Castell Connector Pen Set ',
//       description:
//           'Simply draw and color or clip these pens together to construct interesting models',
//       price: 140,
//       imageUrl:
// 'https://images-na.ssl-images-amazon.com/images/I/81vV1oQlJSL._SL1500_.jpg'    ),
//     Product(
//       id: 'p10',
//       title: 'Puma Women\'s Regular T-Shirt ',
//       description:
//       'Care Instructions: Machine Wash\nFit Type: Regular\nStyle Name:-Tee\nModel Name:-Last Lap Graphic Tee\nBrand Color:-Ignite Pink\nRegular fit ',
//       price: 228,
//       imageUrl:
// 'https://images-na.ssl-images-amazon.com/images/I/71TH8OVeh9L._UL1500_.jpg',
//     ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get favItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  List<Product> get items {
    // if(_showFavoritesOnly)
    //   {
    //     return _items.where((element) => element.isFavorite).toList();
    //   }

    //always return copy of items not the reference to actual items
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  Future<void> addProduct(Product product) async {
    //_items.add(value);
    final url = Uri.parse('https://shoppers-c54d9-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(
          url, body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }
      ));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // notify the listeners about the change
      notifyListeners();

    }
    catch(error){
      print(error);
      throw error;
    }

     //  print(error);
    // throw error;

  }



  Future<void> updateProduct(String id, Product newProduct) async{
   final prodIndex= _items.indexWhere((element) => element.id==id);
   if(prodIndex>=0)
     {
       final url = Uri.parse('https://shoppers-c54d9-default-rtdb.firebaseio.com/products/$id.json');
       await http.patch(url, body: json.encode({
         'title': newProduct.title,
         'description': newProduct.description,
         'imageUrl':newProduct.imageUrl,
         'price':newProduct.price,
       }));
       _items[prodIndex]=newProduct;
       notifyListeners();
     }
   else{
     print('...');
   }
  }

  Future<void> deleteProduct(String id) async{
    final url = Uri.parse('https://shoppers-c54d9-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex = _items.indexWhere((element) => element.id==id);
    var existingProduct = _items[existingProductIndex];
   //optimistic updating pattern
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
          if(response.statusCode>=400)
            {
              _items.insert(existingProductIndex, existingProduct);
              notifyListeners();
              throw HttpException("Could not delete product.");
            }
            existingProduct = null;
       // re-add the product if it fails
  }

  Future<void> fetchAndSetProducts() async{
    final url = Uri.parse('https://shoppers-c54d9-default-rtdb.firebaseio.com/products.json');
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    }catch(error)
    {
      throw (error);
    }
  }
}
