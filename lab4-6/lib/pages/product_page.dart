// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
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
        //add image here
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    Image.asset(
                      "assets/images/1board.png",
                      width: 300,
                      height: 600,
                      scale: 1.5,
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
                            "Product name",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("\$200.00",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightGreen)),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
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
