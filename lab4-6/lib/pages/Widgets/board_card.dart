import 'package:flutter/material.dart';
import 'package:lab4/models/product.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 2,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Stack(alignment: Alignment.center, children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 220,
                child: Image.asset(product.image),
              ),
              Column(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.price.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ]),
        Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: const Icon(Icons.favorite_border_rounded),
              onPressed: () {
                // Handle the like action
              },
            )),
      ]),
    );
  }
}
