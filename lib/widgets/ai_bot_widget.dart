import 'package:flutter/material.dart';

class FlexAIBot {
  static void openChat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => const Center(child: Text("مساعد فلكس الذكي 🤖 جاهز لخدمتك", style: TextStyle(color: Color(0xFFD4AF37)))),
    );
  }
}
