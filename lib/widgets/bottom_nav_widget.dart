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
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              _navBtn(Icons.home_filled, "الرئيسية", 0),
              _navBtn(Icons.map_outlined, "الخرائط", 1),
              _navBtn(Icons.storefront, "المتجر", 2),
            ]),
            const SizedBox(width: 40), // مساحة للزر العائم
            Row(children: [
              _navBtn(Icons.wallet_outlined, "المحفظة", 4),
              _navBtn(Icons.chat_bubble_outline, "دردشة", 5),
              _navBtn(Icons.person_outline, "حسابي", 6),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _navBtn(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFD4AF37) : Colors.grey, size: 24),
            Text(label, style: TextStyle(color: isSelected ? const Color(0xFFD4AF37) : Colors.grey, fontSize: 8)),
          ],
        ),
      ),
    );
  }
}
