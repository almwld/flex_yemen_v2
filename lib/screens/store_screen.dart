import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cats = [
    {"n": "مجوهرات", "i": Icons.diamond, "c": Colors.blueAccent},
    {"n": "فضيات يمنية", "i": Icons.Brightness_7, "c": Colors.grey},
    {"n": "سوبر ماركت", "i": Icons.shopping_basket, "c": Colors.green},
    {"n": "إلكترونيات", "i": Icons.laptop_mac, "c": Colors.blue},
    {"n": "أزياء", "i": Icons.checkroom, "c": Colors.purple},
    {"n": "عطور", "i": Icons.auto_awesome, "c": Colors.pink},
    {"n": "أدوات منزلية", "i": Icons.kitchen, "c": Colors.teal},
    {"n": "ألعاب", "i": Icons.smart_toy, "c": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: cats.length,
      itemBuilder: (context, i) => Container(
        decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(cats[i]['i'], color: cats[i]['c']),
          const SizedBox(height: 5),
          Text(cats[i]['n'], style: const TextStyle(fontSize: 10, color: Colors.white)),
        ]),
      ),
    );
  }
}
