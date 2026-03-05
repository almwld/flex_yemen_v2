import 'package:flutter/material.dart';

class UploadProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("إضافة منتج جديد 💎", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
          const SizedBox(height: 20),
          // زر اختيار الصور من الاستوديو
          InkWell(
            onTap: () => print("فتح الاستوديو"),
            child: Container(
              height: 150, width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD4AF37), style: BorderStyle.none),
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, size: 50, color: Color(0xFFD4AF37)),
                  Text("اضغط لاختيار صور المنتج من الاستوديو", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _inputField("اسم المنتج", Icons.edit),
          _inputField("السعر (ريال يمني)", Icons.money),
          _inputField("وصف المنتج", Icons.description, maxLines: 3),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
              onPressed: () {},
              child: const Text("نشر الإعلان الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFFD4AF37)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
