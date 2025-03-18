import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/logic/cubit/cart/add_to_cart_cubit.dart';
import 'package:grocery_store/models/address.dart';
import 'package:grocery_store/models/purchasedItems.dart';
import 'package:grocery_store/presentation/home_page.dart';
import 'package:grocery_store/repositary/firebase%20database/grocery_list_firestore.dart';

class CheckoutScreen extends StatelessWidget {
  var _groceryListFireStore = GroceryListFireStore();
  var name = "";

  num price = 0.0;
  var image = "";
  var desc = "";
  var quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text('Checkout')),
      body: BlocBuilder<AddToCartCubit, AddToCartState>(
        builder: (context, state) {
          if (state is AddToCartSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                           name = state.cartItems[index]["itemName"];

                           price =
                              state.cartItems[index]["price"];
                           image =
                              state.cartItems[index]["image"].toString();
                           desc =
                              state.cartItems[index]["description"].toString();
                           quantity =
                              state.cartItems[index]["quantity"];

                          return Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Flexible(child: Text(name)),
                              trailing: Text('₹${price.toStringAsFixed(2)}',style:TextStyle(fontSize:15)),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Total: \₹${context.read<AddToCartCubit>().total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final _formKey = GlobalKey<FormState>();
                            final _addressController = TextEditingController();
                            final _cityController = TextEditingController();
                            final _stateController = TextEditingController();
                            final _zipController = TextEditingController();

                            return _address(_formKey, _addressController, _cityController, _stateController, _zipController, context);
                          },
                        );
                      },
                      child:  Center(
                        child: Text(
                          'Proceed to Payment',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  AlertDialog _address(GlobalKey<FormState> _formKey, TextEditingController _addressController, TextEditingController _cityController, TextEditingController _stateController, TextEditingController _zipController, BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
                            title: Text('Enter Address'),
                            
                            content: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Note only COD is available",style: GoogleFonts.poppins(color: Colors.red),),
                                    TextFormField(
                                      controller: _addressController,
                                      decoration: InputDecoration(labelText: 'Address'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your address';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _cityController,
                                      decoration: InputDecoration(labelText: 'City'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your city';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _stateController,
                                      decoration: InputDecoration(labelText: 'State'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your state';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _zipController,
                                      decoration: InputDecoration(labelText: 'ZIP Code'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your ZIP code';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                   _groceryListFireStore.saveAddressToDataBase(items: Address(address: _addressController.text, city: _cityController.text, state: _stateController.text, zipCode: _zipController.text));
                                 ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color.fromRGBO(103, 58, 183, 1),
                            content: Text("Order Completed"),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageScreen(),
                          ),
                        );
                        context.read<AddToCartCubit>().deleteProduct();
                        _groceryListFireStore.saveGroceryToDataBase(
                          items: Item(
                            description: desc,
                            image: image,
                            itemName: name,
                            price: price,
                            quantity: quantity,
                          ),
                        );
                                  }
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          );
  }
}

