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
      AddPostScreen(),          
      WalletScreen(), 
      ChatListScreen(), 
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
        title: Text("FLEX YEMEN", style: GoogleFonts.cairo(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          _buildCartBadge(),
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined, color: const Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
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
          Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _navItem(Icons.home_filled, "الرئيسية", 0),
            _navItem(Icons.map_outlined, "الخرائط", 1),
            _navItem(Icons.storefront_outlined, "المتجر", 2),
          ])),
          const SizedBox(width: 50),
          Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _navItem(Icons.account_balance_wallet_outlined, "المحفظة", 4),
            _navItem(Icons.chat_bubble_outline, "دردشة", 5),
            _navItem(Icons.person_outline, "حسابي", 6),
          ])),
        ],
      ),
    ),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: GoogleFonts.cairo(fontSize: 8, fontWeight: FontWeight.bold, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey)),
    ]),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.symmetric(vertical: 10),
    children: [
      // نظام البحث
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "ابحث عن عقار، سيارة، أو منتج...",
              prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      
      // شريط الإعلانات (تصحيح الرموز)
      SizedBox(
        height: 160,
        child: PageView(
          children: [
            _adSlide("عروض فلكس", "خصومات تصل إلى 50\%", Colors.amber[900]!),
            _adSlide("سيارات 2024", "وصلت حديثاً إلى معارضنا", Colors.blueGrey[800]!),
          ],
        ),
      ),
      const SizedBox(height: 15),

      // المحتوى (تم تصحيح الـ $)
      _itemCard("فيلا فاخرة - حي حدة", "650,000 \$", "صنعاء", Icons.home_work, Colors.blue),
      _itemCard("تويوتا لاندكروزر 2024", "98,000 \$", "عدن", Icons.directions_car, Colors.red),
      _itemCard("أرض استثمارية - المطار", "220,000 \$", "صنعاء", Icons.landscape, Colors.green),
    ],
  );

  Widget _adSlide(String t, String s, Color c) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(15)),
    child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      Text(s, style: const TextStyle(color: Colors.white70)),
    ])),
  );

  Widget _itemCard(String t, String p, String l, IconData i, Color c) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    color: const Color(0xFF1A1A1A),
    child: ListTile(
      leading: Icon(i, color: c),
      title: Text(t),
      subtitle: Text(l),
      trailing: Text(p, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
    ),
  );
}

// الصفحات الفرعية فارغة للاختصار وضمان استقرار الكود
class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});
  @override Widget build(BuildContext context) => const Center(child: Text("المتجر"));
}
class WalletScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المحفظة")); }
class ChatListScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("الدردشة")); }
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("إضافة إعلان")); }
class ProfilePage extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("حسابي")); }
