import 'package:flutter/material.dart';

class FlexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  final int cartCount;

  const FlexAppBar({required this.isDark, required this.onThemeToggle, required this.cartCount});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.settings_outlined, color: Color(0xFFD4AF37)),
        onPressed: () => Scaffold.of(context).openDrawer(), // زر الإعدادات/الزاوية
      ),
      title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFD4AF37)), onPressed: () {}),
            if (cartCount > 0)
              Positioned(right: 8, top: 8, child: CircleAvatar(radius: 7, backgroundColor: Colors.red, child: Text("$cartCount", style: const TextStyle(fontSize: 9)))),
          ],
        ),
        IconButton(
          icon: Icon(isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round, color: const Color(0xFFD4AF37)),
          onPressed: onThemeToggle,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
