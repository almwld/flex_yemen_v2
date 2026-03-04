import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/store_screen.dart';
import 'screens/wallet_screen.dart';
import 'widgets/ai_bot_widget.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: const Color(0xFFD4AF37)),
      home: Scaffold(
        appBar: AppBar(
          title: Text("FLEX YEMEN PRO", style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: const Color(0xFFD4AF37))),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const Center(child: Text("الرئيسية (قيد التطوير)")),
            StoreScreen(),  // تم ربطه من الملف المستقل
            WalletScreen(), // تم ربطه من الملف المستقل
            const Center(child: Text("حسابي")),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFD4AF37),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: "المتجر"),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "المحفظة"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFD4AF37),
          onPressed: () => FlexAIBot.openChat(context), // البوت من ملفه المستقل
          child: const Icon(Icons.smart_toy, color: Colors.black),
        ),
      ),
    );
  }
}
