import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/Apis/products.dart';
import 'package:grocery_store/logic/cubit/cart/add_to_cart_cubit.dart';
import 'package:grocery_store/models/add_to_cart.dart';
import 'package:grocery_store/models/single_product.dart';

class ProductDescription extends StatefulWidget {
  final id;
  int quantity = 1;

  ProductDescription({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  final _products = ProductsAPI();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Details", style: GoogleFonts.poppins()),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<SingleProductModel?>(
        future: _products.getSingleProduct(widget.id),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapShot.hasError) {
            return Center(child: Text('Error: ${snapShot.error}'));
          } else if (snapShot.hasData && snapShot.data != null) {
            final product = snapShot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product.images![0],
                        height: 300,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      product.title.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.description.toString(),
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "\₹ ${product.price.toString()}",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Qty', // This should be a variable representing the quantity
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (widget.quantity > 0) {
                              setState(() {
                                widget.quantity--;
                              });
                            }
                          },
                        ),
                        Text(
                          widget.quantity.toString(),
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              widget.quantity++;
                            });
                            // Increase quantity functionality
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print("printitng");
                          context.read<AddToCartCubit>().addProduct(
                            AddToCartModel(
                              itemName: product.title,
                              description: product.description,
                              image: product.images![0].toString(),
                              quantity: widget.quantity,
                              price: product.price,
                            ),
                          );

                          context.read<AddToCartCubit>().getTotal(
                            product.price!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromRGBO(103, 58, 183, 1),
                              content: Text("Product Added Successfully"),
                            ),
                          );
                        },

                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('Product not found'));
          }
        },
      ),
    );
  }
}
