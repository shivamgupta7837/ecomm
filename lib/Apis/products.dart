import 'dart:convert';

import 'package:grocery_store/models/grocery_barCode_scanner_model.dart';
import 'package:grocery_store/models/grocery_items_model.dart';
import 'package:grocery_store/models/single_product.dart';
import 'package:http/http.dart' as http;

class ProductsAPI {
 Future<List<Product>?>getResultFromApi(
      ) async {
        final List<Product> productList = [];
    try {
      final response = await http.get(Uri.parse("https://dummyjson.com/products"));
          
      final data = await jsonDecode(response.body);
      print(data);
      

   if(response.statusCode == 200){
     for (var i = 0; i < data["products"].length; i++) {
       productList.add(Product.fromJson(data["products"][i]));
     }
  return productList;
   }
    } catch (e) {
      print("Error from Products: $e");
    }
    return null;
  }


 Future<SingleProductModel?>getSingleProduct(
  int id
      ) async {
        final List<Product> productList = [];
    try {
      final response = await http.get(Uri.parse("https://dummyjson.com/products/$id"));
          
      final data = await jsonDecode(response.body);
      print(data);
      

   if(response.statusCode == 200){
     
  return SingleProductModel.fromJson(data);
   }
    } catch (e) {
      print("Error from Products: $e");
    }
    return null;
  }
}
