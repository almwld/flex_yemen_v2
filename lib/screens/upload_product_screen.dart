import 'package:flutter/material.dart';

class UploadProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("رفع إعلان جديد 📸", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
          const SizedBox(height: 20),
          Container(
            height: 180, width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFD4AF37))),
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.cloud_upload_outlined, size: 50, color: Color(0xFFD4AF37)), Text("اضغط هنا لاختيار صور من الاستوديو")]),
          ),
          const SizedBox(height: 20),
          _field("اسم المنتج"),
          _field("السعر"),
          _field("الوصف", lines: 3),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)), child: const Text("نشر الآن", style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
  Widget _field(String label, {int lines = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(maxLines: lines, decoration: InputDecoration(labelText: label, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
  );
}
