import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // نظام البحث الاحترافي
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "ابحث عن عقارات، سيارات، أو مجوهرات...",
                prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
        // السلايدر (Carousel)
        Container(
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A1A), Color(0xFFD4AF37)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Text(
              "عروض فلكس يمن الحصرية\nمجوهرات - سيارات - عقارات",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle("العروض المميزة اليوم"),
        _buildQuickItem("خاتم فضة يمني ملكي", "35,000 RY"),
        _buildQuickItem("شقة للبيع - حي حدة", "120,000 $"),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.all(15),
    child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
  );

  Widget _buildQuickItem(String name, String price) => ListTile(
    leading: const Icon(Icons.star, color: Color(0xFFD4AF37)),
    title: Text(name),
    trailing: Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
  );
}
