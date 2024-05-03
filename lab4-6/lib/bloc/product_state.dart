part of 'product_bloc.dart';

abstract class ProductState {
  final List<Product> cart;

  ProductState({this.cart = const []});
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({required this.products}) : super(cart: []);
}

class CartUpdated extends ProductState {
  CartUpdated({required List<Product> cart}) : super(cart: cart);
}

class ProductLoading extends ProductState {}
