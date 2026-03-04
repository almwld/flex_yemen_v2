import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("اكتشف فلكس يمن", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _featuredCard("عقارات فاخرة", "أفضل الفلل في صنعاء", Icons.domain),
        _featuredCard("سيارات حديثة", "عروض معرض فلكس", Icons.directions_car_filled),
      ],
    );
  }

  Widget _featuredCard(String title, String subtitle, IconData icon) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: const Color(0xFF1A1A1A),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFFD4AF37), size: 40),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      );
}
