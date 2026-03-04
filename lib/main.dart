import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatefulWidget {
  @override
  _FlexYemenAppState createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  bool isDarkMode = true;
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD4AF37),
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainNavigation(
        isDarkMode: isDarkMode,
        cartCount: cartCount,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        onAddToCart: () => setState(() => cartCount++),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final bool isDarkMode;
  final int cartCount;
  final VoidCallback onThemeToggle;
  final VoidCallback onAddToCart;
  MainNavigation({required this.isDarkMode, required this.cartCount, required this.onThemeToggle, required this.onAddToCart});
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),             
      const Center(child: Text("خريطة اليمن الذكية")), 
      StoreScreen(onAdd: widget.onAddToCart), 
      const Center(child: Text("إضافة إعلان جديد")),          
      const Center(child: Text("المحفظة المالية")), 
      const Center(child: Text("الدردشة والوساطة")), 
      ProfilePage(),            
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined, color: Color(0xFFD4AF37)),
          onPressed: () => setState(() => _currentIndex = 6),
        ),
        title: Text("FLEX YEMEN", 
          style: GoogleFonts.cairo(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        actions: [
          _buildCartBadge(),
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined, color: const Color(0xFFD4AF37)), 
            onPressed: widget.onThemeToggle
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildModernNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add_rounded, color: Colors.black, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCartBadge() => Stack(
    children: [
      IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFD4AF37)), onPressed: () {}),
      if (widget.cartCount > 0)
        Positioned(right: 8, top: 8, child: CircleAvatar(radius: 7, backgroundColor: Colors.red, child: Text(widget.cartCount.toString(), style: const TextStyle(fontSize: 9, color: Colors.white)))),
    ],
  );

  Widget _buildModernNav() => BottomAppBar(
    color: widget.isDarkMode ? const Color(0xFF151515) : Colors.white,
    shape: const CircularNotchedRectangle(),
    notchMargin: 10,
    child: Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // الجهة اليمنى (3 أيقونات)
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(Icons.home_filled, "الرئيسية", 0),
              _navItem(Icons.map_outlined, "الخرائط", 1),
              _navItem(Icons.storefront_outlined, "المتجر", 2),
            ],
          )),
          const SizedBox(width: 50), // مساحة للزر الذهبي
          // الجهة اليسرى (3 أيقونات)
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(Icons.account_balance_wallet_outlined, "المحفظة", 4),
              _navItem(Icons.chat_bubble_outline, "دردشة", 5),
              _navItem(Icons.person_outline, "حسابي", 6),
            ],
          )),
        ],
      ),
    ),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 24),
        Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    Text("اكتشف فلكس يمن", style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold)),
    const SizedBox(height: 15),
    _card("عقارات فاخرة", Icons.domain),
    _card("سيارات حديثة", Icons.directions_car),
  ]);
  Widget _card(String t, IconData i) => Card(color: const Color(0xFF1A1A1A), child: ListTile(leading: Icon(i, color: const Color(0xFFD4AF37)), title: Text(t)));
}

class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});
  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 3, padding: const EdgeInsets.all(15), mainAxisSpacing: 10, crossAxisSpacing: 10,
    children: [
      _cat(Icons.shopping_basket, "ماركت"), _cat(Icons.restaurant, "مطاعم"), _cat(Icons.devices, "تقنية"),
    ],
  );
  Widget _cat(IconData i, String n) => InkWell(onTap: onAdd, child: Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(i, color: const Color(0xFFD4AF37)), Text(n, style: const TextStyle(fontSize: 10))])));
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("الإعدادات"));
}
