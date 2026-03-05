import 'package:flutter/material.dart';

class NewsTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      color: Colors.amber.withOpacity(0.1),
      child: Center(
        child: Text(
          "📢 تنبيه: تحديث أسعار الصرف والذهب يتم لحظياً عبر سوبابيس",
          style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
