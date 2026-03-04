import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 30),
        CircleAvatar(radius: 50, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black)),
        Text("المستخدم اليمني", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text("عضو بريميوم", style: TextStyle(color: Color(0xFFD4AF37))),
        Divider(height: 40),
        _item(Icons.shopping_bag, "مشترياتي"),
        _item(Icons.favorite, "المفضلة"),
        _item(Icons.settings, "الإعدادات الأمنية"),
        _item(Icons.help, "مركز الدعم"),
        _item(Icons.logout, "تسجيل الخروج", color: Colors.red),
      ]),
    );
  }
  Widget _item(IconData i, String t, {Color color = Colors.white}) => ListTile(leading: Icon(i, color: color), title: Text(t, style: TextStyle(color: color)));
}
