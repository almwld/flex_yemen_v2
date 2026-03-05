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
      leading: IconButton(
        icon: const Icon(Icons.settings_suggest_outlined, color: Color(0xFFD4AF37)),
        onPressed: () {},
      ),
      title: const Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, color: const Color(0xFFD4AF37)),
          onPressed: onThemeToggle,
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFD4AF37)),
          onPressed: () {},
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
