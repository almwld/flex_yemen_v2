import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_widget.dart';
import 'screens/ai_upload_screen.dart';

void main() => runApp(const FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  const FlexYemenApp({super.key});
  @override
  State<FlexYemenApp> createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> with SingleTickerProviderStateMixin {
  bool isDarkMode = true;
  int _currentIndex = 0;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void _handleNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  void _onFabPressed() {
    _rotationController.forward(from: 0.0);
    setState(() => _currentIndex = 3); // صفحة الرفع والذكاء الاصطناعي
  }

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
          cartCount: 2,
          onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            Center(child: Text("الرئيسية")),
            Center(child: Text("خرائط الخدمات")),
            Center(child: Text("المتجر")),
            AIUploadScreen(), // زر الرفع المتحرك يفتح هذه الواجهة
            Center(child: Text("المحفظة")),
            Center(child: Text("الدردشة والوساطة")),
            Center(child: Text("الحساب")),
          ],
        ),
        bottomNavigationBar: FlexBottomNav(
          currentIndex: _currentIndex,
          onTap: _handleNavTap,
        ),
        floatingActionButton: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) => Transform.rotate(
            angle: _rotationController.value * 2 * math.pi,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFFD4AF37),
              onPressed: _onFabPressed,
              child: const Icon(Icons.add_rounded, color: Colors.black, size: 35),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
