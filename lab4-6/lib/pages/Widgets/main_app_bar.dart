import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xFF08304e),
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
                const Text(
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
                    icon: const Icon(Icons.shopping_bag_outlined,
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
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
