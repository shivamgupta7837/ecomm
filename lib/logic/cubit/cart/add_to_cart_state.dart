part of 'add_to_cart_cubit.dart';

sealed class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

final class AddToCartInitial extends AddToCartState {}
final class AddToCartLoading extends AddToCartState {}

final class AddToCartSuccess extends AddToCartState {
  List<Map<String, dynamic>> cartItems = [];

   AddToCartSuccess({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}


final class AddToCartFailure extends AddToCartState {
  final String error;

  const AddToCartFailure(this.error);

  @override
  List<Object> get props => [error];
}
