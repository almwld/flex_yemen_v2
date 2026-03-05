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
      // زر الإعدادات في الجهة اليسرى (أو اليمنى حسب اتجاه اللغة)
      leading: IconButton(
        icon: const Icon(Icons.settings_suggest_outlined, color: Color(0xFFD4AF37)),
        onPressed: () => print("الاعدادات"),
      ),
      title: const Text("FLEX YEMEN", 
        style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 2)
      ),
      centerTitle: true,
      // أزرار السلة والثيم في الجهة الأخرى
      actions: [
        IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: const Color(0xFFD4AF37)),
          onPressed: onThemeToggle,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFD4AF37)),
              onPressed: () {},
            ),
            Positioned(
              right: 8, top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                child: const Text('0', style: TextStyle(fontSize: 8, color: Colors.white), textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
