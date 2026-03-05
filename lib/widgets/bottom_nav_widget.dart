import 'package:flutter/material.dart';

class FlexBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const FlexBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              _btn(Icons.home_filled, "الرئيسية", 0),
              _btn(Icons.map_outlined, "الخرائط", 1),
              _btn(Icons.storefront, "المتجر", 2),
            ]),
            const SizedBox(width: 40),
            Row(children: [
              _btn(Icons.wallet_outlined, "المحفظة", 4),
              _btn(Icons.chat_bubble_outline, "دردشة", 5),
              _btn(Icons.person_outline, "حسابي", 6),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _btn(IconData i, String l, int index) => InkWell(
    onTap: () => onTap(index),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(i, color: currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
        Text(l, style: TextStyle(fontSize: 8, color: currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey)),
      ]),
    ),
  );
}
