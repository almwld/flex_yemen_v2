import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'screens/home_screen.dart';
import 'screens/store_screen.dart';
import 'screens/wallet_screen.dart';
import 'widgets/ai_bot_widget.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: const Color(0xFFD4AF37)),
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> with SingleTickerProviderStateMixin {
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

  void _onUploadPressed() {
    _rotationController.forward(from: 0.0);
    // منطق الرفع هنا
    print("فتح متصفح الرفع...");
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),
      const Center(child: Text("الخرائط")),
      StoreScreen(),
      const Center(child: Text("صفحة الرفع")), // صفحة وسيطة
      WalletScreen(),
      const Center(child: Text("الدردشة")),
      const Center(child: Text("حسابي")),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: AnimatedBuilder(
        animation: _rotationController,
        builder: (context, child) => Transform.rotate(
          angle: _rotationController.value * 2 * math.pi,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFD4AF37),
            onPressed: _onUploadPressed,
            child: const Icon(Icons.add_circle_outline, color: Colors.black, size: 30),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFD4AF37),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "خرائط"),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: "المتجر"),
            BottomNavigationBarItem(icon: Icon(Icons.upload_file, color: Colors.transparent), label: "رفع"), // مكان الزر العائم
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "محفظة"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "دردشة"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
