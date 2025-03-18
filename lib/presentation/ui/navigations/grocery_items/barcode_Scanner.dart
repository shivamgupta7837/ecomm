import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/Apis/grocery_barCode_scanner_api.dart';
import 'package:grocery_store/logic/bloc/grocery_items/grocery_items_bloc.dart';
import 'package:grocery_store/logic/cubit/cart/add_to_cart_cubit.dart';
import 'package:grocery_store/models/add_to_cart.dart';
import 'package:grocery_store/models/mannual_data.dart';
import 'package:grocery_store/repositary/firebase%20database/grocery_list_firestore.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarcodeScanner extends StatelessWidget {
    final groceryListFireStore = GroceryListFireStore();
  BarcodeScanner({super.key});
  final _obj = GroceryBarCodeScannerAPI();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroceryItemsBloc, GroceryItemsState>(
      builder: (context, state) {
        return Column(
          children: [
            Image.asset("assets/features/qr.png", height: 90),

            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),
              onPressed: () async {
                String? res = await SimpleBarcodeScanner.scanBarcode(
                  context,
                  barcodeAppBar: const BarcodeAppBar(
                    appBarTitle: 'Scan QR',
                    centerTitle: false,
                    enableBackButton: true,
                    backButtonIcon: Icon(Icons.arrow_back_ios),
                  ),
                  isShowFlashIcon: true,
                  delayMillis: 2000,
                  cameraFace: CameraFace.back,
                );
                saveGroceryUsingQR(res.toString(), context);
              },
              child: Text("Scan QR", style: GoogleFonts.poppins(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  saveGroceryUsingQR(String code, BuildContext context) async {
    String? brandName = " ";
    String? description = "";
    String? image = "";

    // final data = await _obj.getResultFromApi(UpcCode: code);
    // print("data: ${data!.gTINTestResults![0].brandName}");

    // for (int i = 0; i < data!.gTINTestResults!.length; i++) {
    //   brandName = data.gTINTestResults![i].brandName;
    //   description = data.gTINTestResults![i].productDescription;
    //   image = data.gTINTestResults![i].productImageUrl;
    //   if(brandName!.isNotEmpty){
    //     break;
    //   }
    //   print("image $brandName");
    // }

//  _obj.getProduct();



    ManualData? data = await groceryListFireStore.getManualDataFromDataBase(code);
    print("aaaaaa: ${data!.name}");


    if(context.mounted){
if(data == null){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromRGBO(103, 58, 183, 1),
        content: Text("Prduct not found !!"),
      ),
    );

}else{
      context.read<AddToCartCubit>().addProduct(
      AddToCartModel(
        itemName: data.name,
        image: "",
        quantity: int.parse(data.quantity??"0"),
        price:  data.price
      ),
    );

    
    context.read<AddToCartCubit>().getTotal(10);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromRGBO(103, 58, 183, 1),
        content: Text("Product Added Successfully"),
      ),
    );
}


    }
  }
}
