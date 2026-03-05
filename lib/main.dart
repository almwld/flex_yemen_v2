import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/store_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/upload_product_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(),
      Center(child: Text("خريطة الخدمات")), // سيتم تطويرها لاحقاً
      StoreScreen(),
      UploadProductScreen(),
      WalletScreen(),
      ChatScreen(),
      ProfileScreen(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, textTheme: GoogleFonts.cairoTextTheme()),
      darkTheme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme)),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: FlexAppBar(isDark: isDarkMode, onThemeToggle: () => setState(() => isDarkMode = !isDarkMode)),
        body: pages[_currentIndex],
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
