import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildBalanceCard(),
          SizedBox(height: 25),
          _buildQuickActions(),
          SizedBox(height: 25),
          _buildTransactionHistory(),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(25),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
      borderRadius: BorderRadius.circular(25),
      boxShadow: [BoxShadow(color: Color(0xFFD4AF37).withOpacity(0.3), blurRadius: 10)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الرصيد المتاح", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        Text("1,250,500 RY", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
        Divider(color: Colors.black12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("الكاش باك: 5,200 RY", style: TextStyle(color: Colors.black87, fontSize: 12)),
            Icon(Icons.account_balance_wallet_outlined, color: Colors.black54),
          ],
        ),
      ],
    ),
  );

  Widget _buildQuickActions() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _actionItem(Icons.add_card, "شحن"),
      _actionItem(Icons.send_rounded, "تحويل"),
      _actionItem(Icons.qr_code_scanner, "مسح QR"),
      _actionItem(Icons.receipt_long, "فواتير"),
    ],
  );

  Widget _actionItem(IconData i, String l) => Column(
    children: [
      CircleAvatar(radius: 25, backgroundColor: Colors.white10, child: Icon(i, color: Color(0xFFD4AF37))),
      SizedBox(height: 8),
      Text(l, style: TextStyle(fontSize: 12)),
    ],
  );

  Widget _buildTransactionHistory() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("آخر العمليات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      _historyTile("شحن رصيد ألعاب", "- 5,000 RY", "منذ ساعتين", Colors.red),
      _historyTile("تحويل من أحمد", "+ 20,000 RY", "أمس", Colors.green),
      _historyTile("كاش باك ذهب", "+ 1,200 RY", "2 مارس", Colors.green),
    ],
  );

  Widget _historyTile(String t, String a, String d, Color c) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(backgroundColor: Colors.white10, child: Icon(Icons.history, size: 20)),
    title: Text(t, style: TextStyle(fontSize: 14)),
    subtitle: Text(d, style: TextStyle(fontSize: 11)),
    trailing: Text(a, style: TextStyle(color: c, fontWeight: FontWeight.bold)),
  );
}
