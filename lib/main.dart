import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_widget.dart';
import 'screens/ai_upload_screen.dart';
import 'widgets/ai_bot_widget.dart';

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

  // تحديد متى يختفي البوت (يختفي في صفحة الرفع 3 وصفحة الخرائط 1)
  bool _shouldShowAiBot() {
    return _currentIndex != 3 && _currentIndex != 1;
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
          cartCount: 5,
          onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        ),
        // استخدام Stack لوضع البوت العائم فوق المحتوى
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: [
                const Center(child: Text("الرئيسية")),
                const Center(child: Text("خرائط الخدمات")),
                const Center(child: Text("المتجر")),
                AIUploadScreen(),
                const Center(child: Text("المحفظة")),
                const Center(child: Text("الدردشة والوساطة")),
                const Center(child: Text("الحساب")),
              ],
            ),
            // البوت العائم الذكي (يظهر ويختفي بأنيميشن)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              bottom: _shouldShowAiBot() ? 100 : -100, // يختفي تحت الشاشة
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _shouldShowAiBot() ? 1.0 : 0.0,
                child: FloatingActionButton.small(
                  heroTag: "ai_bot_btn",
                  backgroundColor: const Color(0xFFD4AF37).withOpacity(0.8),
                  onPressed: () => FlexAIBot.openChat(context),
                  child: const Icon(Icons.auto_awesome, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: FlexBottomNav(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
        floatingActionButton: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) => Transform.rotate(
            angle: _rotationController.value * 2 * math.pi,
            child: FloatingActionButton(
              heroTag: "main_fab",
              backgroundColor: const Color(0xFFD4AF37),
              onPressed: () {
                _rotationController.forward(from: 0.0);
                setState(() => _currentIndex = 3);
              },
              child: const Icon(Icons.add_rounded, color: Colors.black, size: 35),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
