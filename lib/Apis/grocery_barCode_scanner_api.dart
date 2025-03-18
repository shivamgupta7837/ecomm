import 'dart:convert';

import 'package:grocery_store/models/grocery_barCode_scanner_model.dart';
import 'package:http/http.dart' as http;
import 'package:openfoodfacts/openfoodfacts.dart';

class GroceryBarCodeScannerAPI {
  // Future<GroceryBarCodeScannerModel?> getResultFromApi(
  //     {required String UpcCode}) async {
  //       print("UpcCode: $UpcCode");
  //   try {
  //     final response = await http.post(Uri.parse("https://gtincheck.gs1uk.org"),
  //         headers: {
  //           "Accept": "application/json",
  //           "Authorization": "Bearer aaaaaaaaaaaaaaaaaaaa",
  //         },
  //         body: json.encode({
  //           "gtins": [UpcCode]
  //         }));
          
  //     Map<String, dynamic> data = await jsonDecode(response.body);
  //     print("api data: $data");

  //  if(response.statusCode == 200){
  //    return GroceryBarCodeScannerModel.fromJson(data);
  //  }
  //   } catch (e) {
  //     print("Error from GroceryBarCodeScannerAPI: $e");
  //   }
  //   return null;
  // }

}



