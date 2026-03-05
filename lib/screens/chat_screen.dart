import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, i) => ListTile(
        leading: Stack(
          children: [
            CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, color: Colors.black)),
            Positioned(right: 0, bottom: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2)))),
          ],
        ),
        title: Text("مجوهرات اليافعي - وسيط معتمد", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("تم تأكيد عملية الاستلام، شكراً لك", maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("12:40 م", style: TextStyle(fontSize: 10, color: Colors.grey)),
            SizedBox(height: 5),
            CircleAvatar(radius: 8, backgroundColor: Color(0xFFD4AF37), child: Text("2", style: TextStyle(fontSize: 8, color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
