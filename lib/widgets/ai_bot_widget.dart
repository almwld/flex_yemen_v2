import 'package:flutter/material.dart';

class FlexAIBot {
  static void openChat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: const Center(
          child: Text("مساعد فلكس الذكي جاهز لخدمتك", style: TextStyle(color: Color(0xFFD4AF37))),
        ),
      ),
    );
  }
}
