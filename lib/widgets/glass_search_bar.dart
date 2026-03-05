import 'package:flutter/material.dart';
import 'dart:ui';

class GlassSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "ابحث عن الذهب، السيارات، أو المطاعم...",
              hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
              prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
