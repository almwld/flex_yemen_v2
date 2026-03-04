import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Container(
          width: double.infinity, padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(20)),
          child: const Column(children: [
            Text("الرصيد المتاح", style: TextStyle(color: Colors.black54)),
            Text("750,000 RY", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
          ]),
        ),
        const SizedBox(height: 20),
        const ListTile(leading: Icon(Icons.history), title: Text("آخر العمليات")),
        const ListTile(leading: Icon(Icons.account_balance), title: Text("سحب عبر الكريمي/ام فلوس")),
      ]),
    );
  }
}
