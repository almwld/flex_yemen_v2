import 'package:flutter/material.dart';

class FlexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  const FlexAppBar({required this.isDark, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(icon: const Icon(Icons.settings_outlined, color: Color(0xFFD4AF37)), onPressed: () {}),
      title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFD4AF37)), onPressed: () {}),
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
