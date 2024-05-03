// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/bloc/product_bloc.dart';
import 'package:lab4/models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.lightGreen),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    Image.asset(
                      product.image,
                      width: 300,
                      height: 500,
                      fit: BoxFit.fitHeight,
                      // repeat: ImageRepeat.repeat,
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward)),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(product.price.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen)),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<ProductBloc>()
                              .add(AddToCart(product: product));
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.favorite,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(
                        4, // number of icons
                        (index) => IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            visualDensity:
                                VisualDensity(horizontal: -4.0, vertical: -2),
                            icon: Icon(
                              Icons.circle,
                              size: 26,
                              color: [
                                Colors.green,
                                Colors.yellow,
                                Colors.blue,
                                Colors.pink
                              ][index],
                            ))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightGreen,
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Text("Add to cart"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightGreen,
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Text("Buy now"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
