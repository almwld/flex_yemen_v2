import 'package:flutter/material.dart';

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
        brightness: Brightness.light, 
        primaryColor: const Color(0xFFD4AF37),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData(
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
  int _currentIndex = 1; // يفتح على المتجر مباشرة للتأكد من التحديث

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),             
      StoreScreen(onAdd: widget.onAddToCart), 
      const Center(child: Text("خريطة اليمن الذكية", style: TextStyle(color: Color(0xFFD4AF37)))), 
      AddPostScreen(),          
      const Center(child: Text("الدردشة والوساطة")), 
      const Center(child: Text("المحفظة المالية")), 
      ProfilePage(),            
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
        title: Text("FLEX YEMEN", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        actions: [
          _buildCartBadge(),
          IconButton(icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: Color(0xFFD4AF37)), onPressed: widget.onThemeToggle),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 3),
        backgroundColor: Color(0xFFD4AF37),
        child: Icon(Icons.add, color: Colors.black, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCartBadge() => Stack(
    children: [
      IconButton(icon: Icon(Icons.shopping_cart, color: Color(0xFFD4AF37)), onPressed: () {}),
      if (widget.cartCount > 0)
        Positioned(right: 5, top: 5, child: CircleAvatar(radius: 8, backgroundColor: Colors.red, child: Text(widget.cartCount.toString(), style: TextStyle(fontSize: 10, color: Colors.white)))),
    ],
  );

  Widget _buildBottomNav() => BottomAppBar(
    color: widget.isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
    shape: CircularNotchedRectangle(),
    notchMargin: 8,
    child: SizedBox(height: 60, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _navItem(Icons.home, "الرئيسية", 0),
      _navItem(Icons.storefront, "المتجر", 1),
      SizedBox(width: 40),
      _navItem(Icons.chat_bubble_outline, "دردشة", 4),
      _navItem(Icons.person_outline, "حسابي", 6),
    ])),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? Color(0xFFD4AF37) : Colors.grey),
      Text(label, style: TextStyle(color: _currentIndex == index ? Color(0xFFD4AF37) : Colors.grey, fontSize: 10)),
    ]),
  );
}

// --- واجهة الرئيسية (عقارات وسيارات) ---
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.all(15),
    children: [
      Text("العقارات المميزة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
      Card(color: Color(0xFF1A1A1A), child: ListTile(title: Text("فيلا سكنية - صنعاء"), subtitle: Text("السعر: 500,000 \$"), leading: Icon(Icons.home, color: Color(0xFFD4AF37)))),
    ],
  );
}

// --- واجهة المتجر (15 قسم) ---
class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});

  final List<Map<String, dynamic>> cats = [
    {"n": "برايم", "i": Icons.star, "c": Colors.amber},
    {"n": "سوبر ماركت", "i": Icons.shopping_basket, "c": Colors.green},
    {"n": "مطاعم", "i": Icons.restaurant, "c": Colors.orange},
    {"n": "إلكترونيات", "i": Icons.devices, "c": Colors.blue},
    {"n": "ملبوسات", "i": Icons.checkroom, "c": Colors.purple},
    {"n": "ألعاب", "i": Icons.videogame_asset, "c": Colors.red},
    {"n": "تعهد حفلات", "i": Icons.celebration, "c": Colors.pink},
    {"n": "صحة", "i": Icons.medication, "c": Colors.cyan},
    {"n": "جمال", "i": Icons.brush, "c": Colors.deepPurple},
    {"n": "سيارات", "i": Icons.directions_car, "c": Colors.brown},
    {"n": "أطفال", "i": Icons.child_care, "c": Colors.lightBlue},
    {"n": "رياضة", "i": Icons.fitness_center, "c": Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: EdgeInsets.all(15),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemCount: cats.length,
    itemBuilder: (context, i) => InkWell(
      onTap: onAdd,
      child: Card(
        color: Color(0xFF1A1A1A),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(cats[i]['i'], color: cats[i]['c'], size: 30),
          SizedBox(height: 5),
          Text(cats[i]['n'], style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        ]),
      ),
    ),
  );
}

// --- واجهة الملف الشخصي ---
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: EdgeInsets.all(20), children: [
    Center(child: CircleAvatar(radius: 40, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 40, color: Colors.black))),
    SizedBox(height: 20),
    ListTile(leading: Icon(Icons.lock, color: Color(0xFFD4AF37)), title: Text("الخصوصية والأمان")),
    ListTile(leading: Icon(Icons.notifications, color: Color(0xFFD4AF37)), title: Text("الإشعارات")),
    ListTile(leading: Icon(Icons.logout, color: Colors.red), title: Text("تسجيل الخروج")),
  ]);
}

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Text("واجهة إضافة إعلان"));
}
