// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lab4/pages/product_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skateboard Store',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightGreen,
      ),
      home: const ProductListPage(),
    );
  }
}

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(100, 33, 45, 57),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.3),
                        letterSpacing: 1.1),
                  ),
                  Text(
                    'User',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.shopping_bag_outlined,
                          color: Colors.lightGreen),
                      onPressed: () {}),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.lightGreen,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.lightGreen,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3, color: Colors.lightGreen),
            ),
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'Popular'),
              Tab(text: 'Trending'),
              Tab(text: 'All'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGrid('Popular'),
            _buildGrid('Trending'),
            _buildGrid('All'),
          ],
        ),
        //fav button to sort elements
        floatingActionButton: FloatingActionButton(
          //add circle shape
          shape: const CircleBorder(),
          backgroundColor: Colors.lightGreen,
          onPressed: () {},
          child: const Icon(Icons.sort),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 20,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "grid"),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_agenda), label: "rows"),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(String title) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.7),
          itemBuilder: (context, index) {
            var product = {'name': 'Samurai', 'price': 119};
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductPage()),
                  );
                },
                child: BoardCard(product: product));
          },
        ),
      ),
    );
  }
}

class BoardCard extends StatelessWidget {
  const BoardCard({
    super.key,
    required this.product,
  });

  final Map<String, Object> product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(children: [
        Column(children: <Widget>[
          SizedBox(height: 300, child: Image.asset("assets/images/1board.png")),
        ]),
        Positioned(
          left: 52,
          bottom: 20,
          child: Column(
            children: [
              Text(
                '${product['name']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${product['price']}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Positioned(
            right: 20,
            top: 20,
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Handle the like action
              },
            )),
      ]),
    );
  }
}
