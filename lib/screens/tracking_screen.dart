import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تتبع شحنتك", style: GoogleFonts.cairo()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // جزء الخريطة (محاكاة مسار الشحنة في صنعاء كمثال)
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFD4AF37), width: 0.5),
              ),
              child: Stack(
                children: [
                  Center(child: Icon(Icons.map_outlined, size: 100, color: Colors.white10)),
                  Positioned(
                    top: 50, left: 100,
                    child: Icon(Icons.location_on, color: Colors.red, size: 30), // موقع المشتري
                  ),
                  Positioned(
                    bottom: 80, right: 120,
                    child: Icon(Icons.local_shipping, color: Color(0xFFD4AF37), size: 35), // موقع الشحنة
                  ),
                ],
              ),
            ),
          ),
          // تفاصيل الشحنة
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("رقم الشحنة: #FX-9920", style: TextStyle(color: Colors.grey)),
                          Text("خاتم فضة عقيق يمني", style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                        child: Text("في الطريق", style: TextStyle(color: Colors.green, fontSize: 12)),
                      )
                    ],
                  ),
                  Divider(height: 30, color: Colors.white10),
                  ListTile(
                    leading: Icon(Icons.access_time, color: Color(0xFFD4AF37)),
                    title: Text("وقت الوصول المتوقع", style: TextStyle(fontSize: 13)),
                    trailing: Text("خلال 45 دقيقة", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
