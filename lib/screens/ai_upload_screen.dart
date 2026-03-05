import 'package:flutter/material.dart';
import 'dart:math' as math;

class AIUploadScreen extends StatefulWidget {
  @override
  _AIUploadScreenState createState() => _AIUploadScreenState();
}

class _AIUploadScreenState extends State<AIUploadScreen> {
  bool isAnalyzing = true;
  String resultText = "جاري فحص المنتج عبر الذكاء الاصطناعي...";

  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  void _startAnalysis() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        isAnalyzing = false;
        resultText = "تم التحليل ✅\nالمنتج: خاتم عقيق يمني\nالسعر المقترح: 45,000 ريال";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isAnalyzing)
            CircularProgressIndicator(color: Color(0xFFD4AF37))
          else
            Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text(
            resultText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (!isAnalyzing)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37)),
                onPressed: () => print("نشر الإعلان"),
                child: Text("تأكيد ونشر الإعلان", style: TextStyle(color: Colors.black)),
              ),
            )
        ],
      ),
    );
  }
}
