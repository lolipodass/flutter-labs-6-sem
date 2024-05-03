import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddToCart>(_onAddToCart);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) {
    // Load the product data and emit the ProductLoaded state
    List<Product> products = [
      const Product(
          name: 'Samurai', price: 119, image: 'assets/images/1board.png'),
      const Product(
          name: 'Ollie', price: 99, image: 'assets/images/3board.png'),
      const Product(
          name: 'Skateboard', price: 299, image: 'assets/images/4board.png'),
    ];
    emit(ProductLoaded(products: products));
  }

  void _onAddToCart(AddToCart event, Emitter<ProductState> emit) {
    // Add the product to the cart and emit the CartUpdated state
    emit(CartUpdated(cart: [...state.cart, event.product]));
  }
}
