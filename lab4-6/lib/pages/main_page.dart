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
      length: 4, // Updated the number of tabs to 4
      child: Scaffold(
        backgroundColor: Color(0xFF08304e),
        appBar: AppBar(
          backgroundColor: Color(0xFF08304e),
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
              Tab(text: 'Featured'), // Added new tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGrid('Popular'),
            _buildGrid('Trending'),
            _buildGrid('All'),
            _buildPageView(), // Added a PageView widget here
          ],
        ),
        floatingActionButton: SizedBox(
          height: 60,
          child: FittedBox(
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(Icons.sort, size: 28),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF08304e),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 20,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Grid"),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_agenda), label: "Rows"),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    // Sample images to demonstrate the use of PageView
    var images = [
      'assets/images/1board.png',
      'assets/images/3board.png',
      'assets/images/4board.png',
    ];
    return PageView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Image.asset(images[index], fit: BoxFit.contain),
        );
      },
    );
  }

  Widget _buildGrid(String title) {
    List<Map<String, Object>> products = [
      {'name': 'Samurai', 'price': 119, 'image': 'assets/images/1board.png'},
      {'name': 'Ollie', 'price': 99, 'image': 'assets/images/3board.png'},
      {'name': 'Skateboard', 'price': 299, 'image': 'assets/images/4board.png'},
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1.7),
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductPage(
                              product: product,
                            )),
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
                child: Image.asset(product['image'] as String),
              ),
              Column(
                children: [
                  Text(
                    '${product['name']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${product['price']}',
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
