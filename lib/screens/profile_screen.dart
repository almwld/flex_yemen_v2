import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30),
          CircleAvatar(radius: 50, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black)),
          SizedBox(height: 15),
          Text("محمد المولد", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("معرف الحساب: #FLEX990", style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 30),
          _profileOption(Icons.shopping_bag_outlined, "طلباتي"),
          _profileOption(Icons.favorite_border, "المفضلة"),
          _profileOption(Icons.security, "الأمان والخصوصية"),
          _profileOption(Icons.support_agent, "الدعم الفني"),
          _profileOption(Icons.logout, "تسجيل الخروج", c: Colors.red),
        ],
      ),
    );
  }

  Widget _profileOption(IconData i, String l, {Color c = Colors.white}) => ListTile(
    leading: Icon(i, color: c == Colors.red ? c : Color(0xFFD4AF37)),
    title: Text(l, style: TextStyle(color: c)),
    trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
  );
}
