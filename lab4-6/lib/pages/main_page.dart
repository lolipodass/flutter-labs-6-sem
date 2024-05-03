// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4/bloc/product_bloc.dart';
import 'package:lab4/models/product.dart';
import 'package:lab4/pages/Widgets/board_card.dart';
import 'package:lab4/pages/Widgets/main_app_bar.dart';
import 'package:lab4/pages/product_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required List<Product> products});

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => ProductBloc()..add(LoadProducts()),
  //     child: const ProductListPage(),
  //   );
  // }
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
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Color(0xFF08304e),
              appBar: MainAppBar(title: "Skateboard Store"),
              body: TabBarView(
                children: [
                  _buildGrid(state.products),
                  _buildGrid(state.products),
                  _buildGrid(state.products),
                  _buildPageView(),
                ],
              ),
              floatingActionButton: SizedBox(
                height: 60,
                child: FittedBox(
                  child: FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.lightGreen,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(AddToCart(product: state.products[0]));
                    },
                    child: const Icon(Icons.sort, size: 28),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Color(0xFF08304e),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 20,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.grid_view), label: "Grid"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.view_agenda), label: "Rows"),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGrid(List<Product> products) {
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
