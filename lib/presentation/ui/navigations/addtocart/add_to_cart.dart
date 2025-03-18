import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store/logic/cubit/cart/add_to_cart_cubit.dart';
import 'package:grocery_store/presentation/ui/navigations/grocery_items/checkout.dart';

class AddToCartPage extends StatelessWidget {
            double total = 0; // Reset total before recalculating
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocBuilder<AddToCartCubit, AddToCartState>(
          builder: (context, state) {

            if (state is AddToCartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AddToCartSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final name = state.cartItems[index]["itemName"];
                          final image = state.cartItems[index]["image"];
                          final price = state.cartItems[index]["price"].toDouble();
                          final qty = state.cartItems[index]["quantity"].toString();
                          
                          total += price; // Correctly update total

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              // leading: image==""?null:Image.network(image, height: 80, width: 80),
                              title: Flexible(child: Text(name)),
                              subtitle: Text('Qty: $qty'),
                              trailing: Text('\₹${price.toStringAsFixed(2)}'),
                            ),
                          );
                        },
                      ),
                    ),  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ₹${ context.read<AddToCartCubit>().total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckoutScreen()));
                          },
                          child: Text('Checkout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is AddToCartFailure) {
              return Center(child: Text('Failed to add item to cart.'));
            } else {
              return Center(child: Text('No product in cart.'));
            }
          },
        ),
      ),
    );
  }
}
