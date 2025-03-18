import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_store/models/add_to_cart.dart';
import 'package:grocery_store/models/grocery_items_model.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  List<Map<String, dynamic>> cartItems = [];
  double total = 0;
Future<double> getTotal(num t)async{
  total = total+t;
  return  total;
}
  Future<void> addProduct(AddToCartModel product)async {
    print("pro ${product}");
    cartItems.add(product.toJson());
    emit(AddToCartSuccess(cartItems:cartItems));
  }

  List<Product> getProducts() {
    return List.unmodifiable(cartItems);
  }

  Future<void> deleteProduct() async{
    cartItems.clear();
    emit(AddToCartInitial());
  }

}
