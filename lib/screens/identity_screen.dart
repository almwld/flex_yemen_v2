import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint, size: 100, color: Color(0xFFD4AF37)),
            const SizedBox(height: 20),
            Text(
              "توثيق الهوية الذكي",
              style: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "يرجى استخدام بصمة الإصبع أو الوجه لتأكيد هويتك والوصول إلى العمليات المالية الآمنة",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                // محاكاة نجاح البصمة
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم التحقق من البصمة بنجاح ✅", style: TextStyle(fontFamily: 'Cairo'))),
                );
              },
              child: const Text("ابدأ التوثيق الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
