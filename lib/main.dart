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
  int _currentIndex = 1; // يفتح على المتجر مباشرة لمعاينة الأقسام

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),             
      StoreScreen(onAdd: widget.onAddToCart), 
      const Center(child: Text("خريطة اليمن")), 
      AddPostScreen(),          
      const Center(child: Text("المحفظة")), 
      const Center(child: Text("الدردشة")), 
      ProfilePage(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),            
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("FLEX YEMEN", style: GoogleFonts.cairo(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          _buildCartBadge(),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildModernNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add_a_photo_rounded, color: Colors.black),
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
          _navItem(Icons.home_filled, "الرئيسية", 0),
          _navItem(Icons.storefront_outlined, "المتجر", 1),
          const SizedBox(width: 40),
          _navItem(Icons.account_balance_wallet_outlined, "المحفظة", 4),
          _navItem(Icons.person_outline, "حسابي", 6),
        ],
      ),
    ),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 24),
        Text(label, style: GoogleFonts.cairo(fontSize: 10, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey)),
      ]),
    ),
  );
}

// 🏠 الصفحة الرئيسية (مختصرة للتركيز على المتجر)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(child: Text("الرئيسية"));
}

// 🛒 صفحة المتجر الكاملة (15 قسم + مجوهرات وفضيات)
class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});

  final List<Map<String, dynamic>> allCategories = [
    {"n": "مجوهرات", "i": Icons.diamond, "c": Colors.blueAccent},
    {"n": "فضيات يمنية", "i": Icons.Brightness_7, "c": Colors.grey},
    {"n": "سوبر ماركت", "i": Icons.shopping_basket, "c": Colors.green},
    {"n": "مطاعم", "i": Icons.restaurant, "c": Colors.orange},
    {"n": "إلكترونيات", "i": Icons.laptop_mac, "c": Colors.blue},
    {"n": "أزياء وملابس", "i": Icons.checkroom, "c": Colors.purple},
    {"n": "عطور وبخور", "i": Icons.auto_awesome, "c": Colors.pinkAccent},
    {"n": "ألعاب أطفال", "i": Icons.smart_toy, "c": Colors.red},
    {"n": "تعهد حفلات", "i": Icons.celebration, "c": Colors.amber},
    {"n": "أدوات منزلية", "i": Icons.kitchen, "c": Colors.teal},
    {"n": "صحة وجمال", "i": Icons.face, "c": Colors.deepPurple},
    {"n": "معدات بناء", "i": Icons.construction, "c": Colors.brown},
    {"n": "مستلزمات طبية", "i": Icons.medication, "c": Colors.redAccent},
    {"n": "كتب وقرطاسية", "i": Icons.menu_book, "c": Colors.indigo},
    {"n": "عالم الرياضة", "i": Icons.fitness_center, "c": Colors.cyan},
    {"n": "بذور وزراعة", "i": Icons.agriculture, "c": Colors.lightGreen},
    {"n": "قسم التخفيضات", "i": Icons.loyalty, "c": Colors.orangeAccent},
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, 
      mainAxisSpacing: 10, 
      crossAxisSpacing: 10, 
      childAspectRatio: 0.8
    ),
    itemCount: allCategories.length,
    itemBuilder: (context, i) => InkWell(
      onTap: onAdd,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A), 
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.05))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: allCategories[i]['c'].withOpacity(0.1),
                shape: BoxShape.circle
              ),
              child: Icon(allCategories[i]['i'], color: allCategories[i]['c'], size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              allCategories[i]['n'], 
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

// باقي الواجهات
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("رفع إعلان")); }
class ProfilePage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  ProfilePage({required this.onThemeToggle, required this.isDarkMode});
  @override Widget build(BuildContext context) => const Center(child: Text("الحساب"));
}
