import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_store/models/purchasedItems.dart';
import 'package:grocery_store/repositary/firebase%20database/grocery_list_firestore.dart';

class PurchaseHistory extends StatelessWidget {
  
  var _groceryListFireStore = GroceryListFireStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.white,
      body: FutureBuilder(
        future:_groceryListFireStore.getDataFromDataBase(),
        builder: (context,SnapShots) {
          if (SnapShots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (SnapShots.hasError) {
            return Center(child: Text('Error: ${SnapShots.error}'));
          } else if (!SnapShots.hasData || SnapShots.data == null) {
            return Center(child: Text('No data available'));
          }
          return ListView.builder(
            itemCount: SnapShots.data!.length, // Replace with the actual number of orders
            itemBuilder: (context, index) {
              return Card(
            
                margin: EdgeInsets.all(10.0),
              child: ListTile(
                // leading: Image.network(SnapShots.data![index].image.toString()),
                title: Text(SnapShots.data![index].itemName.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
                subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Description: ${SnapShots.data![index].description}'),
                  Text('Quantity: ${SnapShots.data![index].quantity}'),
                  Text('Price: \₹${SnapShots.data![index].price}'),
                 
                ],
                ),
              ),
              );
            },
          );
        }
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PurchaseHistory(),
  ));
}