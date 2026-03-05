import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'core/app_theme.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_widget.dart';
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
    _rotationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: FlexAppBar(isDark: isDarkMode, onThemeToggle: () => setState(() => isDarkMode = !isDarkMode)),
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: const [
                Center(child: Text("الرئيسية")),
                Center(child: Text("الخرائط")),
                Center(child: Text("المتجر")),
                Center(child: Text("الرفع بالذكاء الاصطناعي")),
                Center(child: Text("المحفظة")),
                Center(child: Text("الدردشة")),
                Center(child: Text("حسابي")),
              ],
            ),
            if (_currentIndex != 3) // البوت يختفي في صفحة الرفع
              Positioned(
                bottom: 100, right: 20,
                child: FloatingActionButton.small(
                  backgroundColor: const Color(0xFFD4AF37),
                  onPressed: () => FlexAIBot.openChat(context),
                  child: const Icon(Icons.auto_awesome, color: Colors.black),
                ),
              ),
          ],
        ),
        bottomNavigationBar: FlexBottomNav(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i)),
        floatingActionButton: AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) => Transform.rotate(
            angle: _rotationController.value * 2 * math.pi,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFFD4AF37),
              onPressed: () {
                _rotationController.forward(from: 0);
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
