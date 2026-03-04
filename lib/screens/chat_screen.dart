import 'package:flutter/material.dart';
class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, i) => ListTile(
        leading: CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, color: Colors.black)),
        title: Text("تاجر الفضة - رقم ${i+1}"),
        subtitle: Text("آخر رسالة: هل المنتج متوفر؟"),
        trailing: Text("12:40 م", style: TextStyle(fontSize: 10, color: Colors.grey)),
        onTap: () {},
      ),
    );
  }
}
