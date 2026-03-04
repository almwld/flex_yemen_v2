import 'package:flutter/material.dart';
class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.grey[900], child: Center(child: Icon(Icons.map, size: 100, color: Colors.white24))),
        Positioned(top: 20, left: 20, right: 20, 
          child: Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: Text("خريطة الخدمات في اليمن (صنعاء، عدن، تعز...)", textAlign: TextAlign.center)))
      ],
    );
  }
}
