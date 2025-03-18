import 'package:flutter/material.dart';
import 'package:grocery_store/models/mannual_data.dart';
import 'package:grocery_store/repositary/firebase%20database/grocery_list_firestore.dart';

class ManualProductAdd extends StatelessWidget {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final groceryListFireStore = GroceryListFireStore();

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: productPriceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Barcode Code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                groceryListFireStore.saveManualNardCodeData(
                  items: ManualData(
                    name: productNameController.text,
                    price: int.parse(productPriceController.text),
                    quantity: quantityController.text,
                    code: codeController.text,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color.fromRGBO(103, 58, 183, 1),
                    content: Text("Product Added Successfully"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: ManualProductAdd()));
}
