import 'package:flutter/material.dart';
import 'escrow_system.dart';

class StoreScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cats = [
    {"n": "مجوهرات", "i": Icons.diamond, "c": Colors.blueAccent, "p": "1,500 $"},
    {"n": "فضيات يمنية", "i": Icons.Brightness_7, "c": Colors.grey, "p": "45,000 RY"},
    {"n": "سوبر ماركت", "i": Icons.shopping_basket, "c": Colors.green, "p": "5,000 RY"},
    {"n": "إلكترونيات", "i": Icons.laptop_mac, "c": Colors.blue, "p": "250 $"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: cats.length,
      itemBuilder: (context, i) => InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EscrowSystem(productName: cats[i]['n'], price: cats[i]['p']))),
        child: Container(
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(cats[i]['i'], color: cats[i]['c'], size: 40),
            const SizedBox(height: 10),
            Text(cats[i]['n'], style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(cats[i]['p'], style: const TextStyle(color: Colors.grey, fontSize: 10)),
          ]),
        ),
      ),
    );
  }
}
