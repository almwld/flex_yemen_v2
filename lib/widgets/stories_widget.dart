import 'package:flutter/material.dart';

class BusinessStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(radius: 30, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.store)),
        ),
      ),
    );
  }
}
