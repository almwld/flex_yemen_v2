import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_widget.dart';
import 'screens/upload_product_screen.dart';

void main() => runApp(const FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  const FlexYemenApp({super.key});
  @override
  State<FlexYemenApp> createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, textTheme: GoogleFonts.cairoTextTheme()),
      darkTheme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme)),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: FlexAppBar(isDark: isDarkMode, onThemeToggle: () => setState(() => isDarkMode = !isDarkMode)),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const Center(child: Text("الرئيسية")),
            const Center(child: Text("الخرائط")),
            const Center(child: Text("المتجر")),
            UploadProductScreen(),
            const Center(child: Text("المحفظة")),
            const Center(child: Text("الدردشة")),
            const Center(child: Text("حسابي")),
          ],
        ),
        bottomNavigationBar: FlexBottomNav(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i)),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFD4AF37),
          onPressed: () => setState(() => _currentIndex = 3),
          child: const Icon(Icons.add, color: Colors.black, size: 35),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
