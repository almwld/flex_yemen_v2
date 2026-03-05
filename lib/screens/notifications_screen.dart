import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مركز التنبيهات", style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _buildNotificationItem(
            icon: Icons.trending_up,
            title: "تحديث سعر الذهب",
            desc: "ارتفع سعر جرام الذهب عيار 21 بمقدار 500 ريال الآن.",
            time: "منذ دقيقتين",
            color: Colors.amber,
          ),
          _buildNotificationItem(
            icon: Icons.security,
            title: "تنبيه أمان",
            desc: "تم تسجيل دخول جديد إلى حسابك من جهاز Android في صنعاء.",
            time: "منذ ساعة",
            color: Colors.redAccent,
          ),
          _buildNotificationItem(
            icon: Icons.account_balance_wallet,
            title: "عملية إيداع",
            desc: "تم إضافة 50,000 ريال إلى محفظتك بنجاح.",
            time: "منذ 3 ساعات",
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({required IconData icon, required String title, required String desc, required String time, required Color color}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(time, style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                SizedBox(height: 5),
                Text(desc, style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
