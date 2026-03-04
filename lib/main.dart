import 'package:flutter/material.dart';
// سنستخدم مكتبة الـ SVG عند توفرها، حالياً سنحاكيها بأيقونات عصرية
import 'package:flutter_svg/flutter_svg.dart';

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
      theme: ThemeData(
        fontFamily: 'Cairo', // تطبيق الخط العربي العصري
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Cairo',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
      const Center(child: Text("خريطة اليمن الذكية")), // الخرائط بجانب المتجر
      StoreScreen(onAdd: widget.onAddToCart), 
      const Center(child: Text("إضافة إعلان جديد")),          
      const Center(child: Text("المحفظة المالية")), // المحفظة بجانب الدردشة
      const Center(child: Text("الدردشة والوساطة")), 
      ProfilePage(),            
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.settings_outlined, color: Color(0xFFD4AF37)),
          onPressed: () => setState(() => _currentIndex = 6), // زر الإعدادات في الزاوية
        ),
        title: Center(
          child: Text("FLEX YEMEN", 
            style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 1.5)
          ),
        ),
        actions: [
          _buildCartBadge(),
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined, color: Color(0xFFD4AF37)), 
            onPressed: widget.onThemeToggle
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildModernNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: Color(0xFFD4AF37),
        elevation: 10,
        child: Icon(Icons.add_rounded, color: Colors.black, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCartBadge() => Stack(
    children: [
      IconButton(icon: Icon(Icons.shopping_bag_outlined, color: Color(0xFFD4AF37)), onPressed: () {}),
      if (widget.cartCount > 0)
        Positioned(right: 8, top: 8, child: CircleAvatar(radius: 7, backgroundColor: Colors.red, child: Text(widget.cartCount.toString(), style: TextStyle(fontSize: 9, color: Colors.white)))),
    ],
  );

  Widget _buildModernNav() => BottomAppBar(
    color: widget.isDarkMode ? Color(0xFF151515) : Colors.white,
    shape: CircularNotchedRectangle(),
    notchMargin: 10,
    child: Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            _navItem(Icons.home_filled, "الرئيسية", 0),
            _navItem(Icons.map_outlined, "الخرائط", 1),
            _navItem(Icons.storefront_outlined, "المتجر", 2),
          ]),
          Row(children: [
            _navItem(Icons.account_balance_wallet_outlined, "المحفظة", 4),
            _navItem(Icons.chat_bubble_outline_rounded, "دردشة", 5),
            _navItem(Icons.person_outline_rounded, "حسابي", 6),
          ]),
        ],
      ),
    ),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _currentIndex == index ? Color(0xFFD4AF37) : Colors.grey, size: 26),
          SizedBox(height: 4),
          Text(label, style: TextStyle(color: _currentIndex == index ? Color(0xFFD4AF37) : Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

// (بقية الصفحات HomeScreen, StoreScreen, ProfilePage تبقى كما هي مع تحديث الستايل)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: EdgeInsets.all(20), children: [
    Text("اكتشف فلكس يمن", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    SizedBox(height: 15),
    _featuredCard("عقارات فاخرة", "أفضل الفلل في صنعاء", Icons.domain),
    _featuredCard("سيارات حديثة", "عروض معرض فلكس", Icons.directions_car_filled),
  ]);
  Widget _featuredCard(String t, String s, IconData i) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: Color(0xFF1A1A1A),
    child: ListTile(leading: Icon(i, color: Color(0xFFD4AF37)), title: Text(t), subtitle: Text(s)),
  );
}

class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});
  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 3, padding: EdgeInsets.all(15), mainAxisSpacing: 15, crossAxisSpacing: 15,
    children: [
      _cat(Icons.shopping_cart_checkout, "الماركت"),
      _cat(Icons.restaurant_menu, "المطاعم"),
      _cat(Icons.phone_iphone, "التقنية"),
      _cat(Icons.watch, "اكسسوارات"),
      _cat(Icons.health_and_safety, "الصحية"),
      _cat(Icons.more_horiz, "المزيد"),
    ],
  );
  Widget _cat(IconData i, String n) => InkWell(
    onTap: onAdd,
    child: Container(
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(i, color: Color(0xFFD4AF37)), SizedBox(height: 8), Text(n, style: TextStyle(fontSize: 10))]),
    ),
  );
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text("واجهة الإعدادات والحساب"));
}
