import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_widget.dart';

void main() => runApp(const FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  const FlexYemenApp({super.key});
  @override
  State<FlexYemenApp> createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;
  int _currentIndex = 0;
  int cartCount = 3; // افتراضي للتجربة

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
      ),
      home: Scaffold(
        appBar: FlexAppBar(
          isDark: isDarkMode,
          cartCount: cartCount,
          onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            Center(child: Text("واجهة الرئيسية")),
            Center(child: Text("خريطة الخدمات")),
            Center(child: Text("المتجر الشامل")),
            Center(child: Text("جاري تحليل السعر AI...")),
            Center(child: Text("المحفظة المالية")),
            Center(child: Text("الدردشة والوساطة")),
            Center(child: Text("ملف الحساب")),
          ],
        ),
        bottomNavigationBar: FlexBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFD4AF37),
          onPressed: () => setState(() => _currentIndex = 3),
          child: const Icon(Icons.add_rounded, color: Colors.black, size: 35),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
