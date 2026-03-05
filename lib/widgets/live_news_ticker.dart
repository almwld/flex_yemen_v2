import 'package:flutter/material.dart';

class LiveNewsTicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Color(0xFFD4AF37).withOpacity(0.1),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text("⚡ أسعار الذهب اليوم حية من سوبابيس", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
