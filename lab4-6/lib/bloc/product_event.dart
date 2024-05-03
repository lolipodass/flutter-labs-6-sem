part of 'product_bloc.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class AddToCart extends ProductEvent {
  final Product product;
  AddToCart({required this.product});
}
