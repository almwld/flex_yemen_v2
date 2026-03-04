import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EscrowSystem extends StatefulWidget {
  final String productName;
  final String price;

  EscrowSystem({required this.productName, required this.price});

  @override
  _EscrowSystemState createState() => _EscrowSystemState();
}

class _EscrowSystemState extends State<EscrowSystem> {
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("نظام حماية التاجر", style: GoogleFonts.cairo())),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.security_update_good, size: 80, color: Colors.greenAccent),
            const SizedBox(height: 20),
            Text(
              "سيتم حجز مبلغ (${widget.price}) من المشتري في خزنة فلكس قبل إشعارك بالشحن.",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("المنتج: ${widget.productName}"),
                  Text(widget.price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isLocked ? Colors.grey : const Color(0xFFD4AF37),
                minimumSize: const Size(double.infinity, 55)
              ),
              onPressed: () {
                setState(() => isLocked = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم حجز المبلغ بنجاح ✅"))
                );
              },
              child: Text(isLocked ? "المبلغ محجوز حالياً" : "تفعيل الحجز الآمن", style: const TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
