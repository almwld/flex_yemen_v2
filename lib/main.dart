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
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const Center(child: Text("الرئيسية")),             
      StoreScreen(onAdd: widget.onAddToCart), 
      const Center(child: Text("الخرائط")), 
      const Center(child: Text("إضافة إعلان")),          
      const Center(child: Text("المحفظة")), 
      const Center(child: Text("الدردشة")), 
      const Center(child: Text("حسابي")),            
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
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCartBadge() => Stack(
    children: [
      IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFD4AF37)), onPressed: () {}),
      if (widget.cartCount > 0)
        Positioned(right: 8, top: 8, child: CircleAvatar(radius: 7, backgroundColor: Colors.red, child: Text(widget.cartCount.toString(), style: const TextStyle(fontSize: 9, color: Colors.white)))),
    ],
  );

  Widget _buildBottomNav() => BottomNavigationBar(
    currentIndex: _currentIndex > 1 ? 2 : _currentIndex,
    onTap: (i) => setState(() => _currentIndex = i),
    selectedItemColor: const Color(0xFFD4AF37),
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      BottomNavigationBarItem(icon: Icon(Icons.store), label: "المتجر"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
    ],
  );
}

class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});

  final List<Map<String, dynamic>> cats = [
    {"n": "مجوهرات", "i": Icons.diamond, "c": Colors.blueAccent},
    {"n": "فضيات يمنية", "i": Icons.auto_awesome, "c": Colors.grey},
    {"n": "سوبر ماركت", "i": Icons.shopping_basket, "c": Colors.green},
    {"n": "إلكترونيات", "i": Icons.laptop_mac, "c": Colors.blue},
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(15),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemCount: cats.length,
    itemBuilder: (context, i) => InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: cats[i]['n'], onAdd: onAdd))),
      child: Card(
        color: const Color(0xFF1A1A1A),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(cats[i]['i'], color: cats[i]['c'], size: 40),
          Text(cats[i]['n'], style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
      ),
    ),
  );
}

class ProductListScreen extends StatelessWidget {
  final String category;
  final VoidCallback onAdd;
  ProductListScreen({required this.category, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("منتجات $category")),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, i) => ListTile(
          leading: const Icon(Icons.image, size: 50),
          title: Text("$category - عينة رقم $i"),
          subtitle: const Text("السعر: 15,000 RY"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(name: "$category - عينة رقم $i", onAdd: onAdd))),
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final VoidCallback onAdd;
  ProductDetailScreen({required this.name, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تفاصيل المنتج")),
      body: Column(children: [
        Container(height: 250, width: double.infinity, color: Colors.grey[900], child: const Icon(Icons.image, size: 100)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("وصف المنتج: هذا المنتج عالي الجودة متوفر حصرياً في فلكس يمن بمواصفات عالمية.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const Text("السعر: 25,000 RY", style: TextStyle(fontSize: 20, color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)),
              onPressed: onAdd, 
              child: const Text("إضافة إلى السلة", style: TextStyle(color: Colors.black))
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {}, 
              icon: const Icon(Icons.chat), 
              label: const Text("تواصل مع البائع عبر واتساب")
            ),
          ]),
        )
      ]),
    );
  }
}
