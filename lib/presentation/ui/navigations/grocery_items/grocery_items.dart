import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store/Apis/products.dart';
import 'package:grocery_store/logic/bloc/grocery_items/grocery_items_bloc.dart';
import 'package:grocery_store/models/grocery_items_model.dart';
import 'package:grocery_store/presentation/ui/navigations/grocery_items/barcode_Scanner.dart';
import 'package:grocery_store/presentation/ui/navigations/grocery_items/productDescription.dart';
import 'package:grocery_store/presentation/ui/navigations/grocery_items/update_grocery_items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ProductsItems extends StatefulWidget {
  ProductsItems({Key? key}) : super(key: key);

  @override
  State<ProductsItems> createState() => _ProductsItemsState();
}

class _ProductsItemsState extends State<ProductsItems> {
  final _products = ProductsAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [addGroceryItemWidget(context)],
      ),
      body: FutureBuilder<List<Product>?>(
        future: _products.getResultFromApi(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapShot.hasError) {
            return Center(child: Text('Error: ${snapShot.error}'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  children: [
                    // _titleContainer('Men\'s Clothing', Colors.blue),
                    // _men(snapShot!.data, 4),

                    // _titleContainer('Jewelery', Colors.amber),
                    // _jewelery(snapShot!.data, 4),

                    // _titleContainer('Electronics', Colors.green),
                    // _electronics(snapShot!.data, 6),

                    // _titleContainer('Women\'s Clothing', Colors.pink),
                    // _women(snapShot!.data, 6),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: GridView.builder(
                        itemCount: snapShot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  String title =
                                      snapShot.data![index].title.toString();
                                  String description =
                                      snapShot.data![index].description
                                          .toString();
                                  String price =
                                      snapShot.data![index].price.toString();
                                  String imageUrl =
                                      snapShot.data![index].images![0]
                                          .toString();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ProductDescription(
                                         id:snapShot.data![index].id
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 200,
                                  child: Image.network(
                                    snapShot.data![index].images![0].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                snapShot.data![index].title.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Container _titleContainer(String title, Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: color),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Widget _men(List<Products>? product, int length) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigate to category page
  //     },
  //     child: SizedBox(
  //       height: 400,
  //       child: GridView.builder(
  //         itemCount: length,
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           childAspectRatio: 0.8,
  //           crossAxisCount: 2,
  //           crossAxisSpacing: 5,
  //         ),
  //         itemBuilder: (context, index) {
  //           return Column(
  //             children: [
  //               Container(color: Colors.blueGrey, height: 200,child:  product![index].category == "men's clothing"?Image.network( product![index].image.toString()):null,),
  //               Text(
  //                 product![index].category == "men's clothing"
  //                     ? product![index].title.toString()
  //                     : "",
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget _jewelery(List<Products>? product, int length) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigate to category page
  //     },
  //     child: SizedBox(
  //       height: 400,
  //       child: GridView.builder(
  //         itemCount: length,
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           childAspectRatio: 0.8,
  //           crossAxisCount: 2,
  //           crossAxisSpacing: 5,
  //         ),
  //         itemBuilder: (context, index) {
  //           return Column(
  //             children: [
  //               Container(color: Colors.blueGrey, height: 200,child:  product![index].category == "jewelery"?Image.network( product![index].image.toString()):null,),
  //               Text(
  //                 product![index].category == "jewelery"
  //                     ? product[index].title.toString()
  //                     : "",
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget _electronics(List<Products>? product, int length) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigate to category page
  //     },
  //     child: SizedBox(
  //       height: 400,
  //       child: GridView.builder(
  //         itemCount: length,
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           childAspectRatio: 0.8,
  //           crossAxisCount: 2,
  //           crossAxisSpacing: 5,
  //         ),
  //         itemBuilder: (context, index) {
  //           return Column(
  //             children: [
  //               Container(color: Colors.blueGrey, height: 200,child:  product![index].category == "electronics"?Image.network( product![index].image.toString()):null,),
  //               Text(
  //                 product![index].category == "electronics"
  //                     ? product[index].title.toString()
  //                     : "",
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget _women(List<Products>? product, int length) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigate to category page
  //     },
  //     child: SizedBox(
  //       height: 400,
  //       child: GridView.builder(
  //         itemCount: length,
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           childAspectRatio: 0.8,
  //           crossAxisCount: 2,
  //           crossAxisSpacing: 5,
  //         ),
  //         itemBuilder: (context, index) {
  //           return Column(
  //             children: [
  //               Container(color: Colors.blueGrey, height: 200,child:  product![index].category == "women's clothing"?Image.network( product![index].image.toString()):null,),
  //               Text(
  //                 product![index].category == "women's clothing"
  //                     ? product[index].title.toString()
  //                     : "",
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  FloatingActionButton addGroceryItemWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        _showAlertDialogBox(context: context);
      },
      child: Icon(Icons.add),
    );
  }

  Future<dynamic> _showAlertDialogBox({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Flexible(
                child: Text(
                  "Scan UPC QR to Add Product to cart",
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                BarcodeScanner(),
                SizedBox(height: 15),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
