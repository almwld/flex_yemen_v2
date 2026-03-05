import 'package:flutter/material.dart';

class LiveNewsTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Color(0xFFD4AF37).withOpacity(0.1),
        border: Border(bottom: BorderSide(color: Color(0xFFD4AF37).withOpacity(0.2))),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _tickerItem("⚡ تحديث: سعر الذهب عيار 21 (صنعاء): 65,000 ريال"),
          _tickerItem("💰 دولار/ريال: 530 | سعودي/ريال: 140"),
          _tickerItem("🚀 عرض: خصم 20% في مطاعم رويال دبي لفترة محدودة"),
        ],
      ),
    );
  }

  Widget _tickerItem(String text) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Text(text, style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11, fontWeight: FontWeight.bold)),
  );
}
