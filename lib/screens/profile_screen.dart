import 'package:flutter/material.dart';
import 'identity_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 30),
        const CircleAvatar(radius: 50, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black)),
        const Text("المستخدم اليمني", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const Text("عضو بريميوم", style: TextStyle(color: Color(0xFFD4AF37))),
        const Divider(height: 40),
        
        // زر توثيق الهوية الجديد
        ListTile(
          leading: const Icon(Icons.verified_user, color: Colors.blueAccent),
          title: const Text("توثيق الهوية (بصمة الإصبع)"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => IdentityScreen()));
          },
        ),
        
        _item(Icons.shopping_bag, "مشترياتي"),
        _item(Icons.favorite, "المفضلة"),
        _item(Icons.settings, "الإعدادات الأمنية"),
        _item(Icons.logout, "تسجيل الخروج", color: Colors.red),
      ]),
    );
  }
  Widget _item(IconData i, String t, {Color color = Colors.white}) => ListTile(leading: Icon(i, color: color), title: Text(t, style: TextStyle(color: color)));
}
