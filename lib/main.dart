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

  // قاعدة بيانات المنتجات (مدمجة)
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
    {"n": "عالم الرياضة", "i": Icons.fitness_center, "c": Colors.cyan},
    {"n": "تخفيضات", "i": Icons.loyalty, "c": Colors.orangeAccent},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),             
      const Center(child: Text("خريطة اليمن الذكية")), 
      StoreGrid(categories: allCategories, onAdd: widget.onAddToCart), 
      AddPostScreen(),          
      WalletScreen(), 
      ChatListScreen(), 
      ProfilePage(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),            
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
        actions: [_buildCartBadge()],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildModernNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAIChat(context), // البوت الذكي كزر عائم
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.psychology, color: Colors.black, size: 30),
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
    notchMargin: 8,
    child: Container(
      height: 60,
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
            _navItem(Icons.chat_bubble_outline, "دردشة", 5),
            _navItem(Icons.person_outline, "حسابي", 6),
          ]),
        ],
      ),
    ),
  );

  Widget _navItem(IconData icon, String label, int index) => InkWell(
    onTap: () => setState(() => _currentIndex = index),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
        Text(label, style: GoogleFonts.cairo(fontSize: 8, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey)),
      ]),
    ),
  );

  void _showAIChat(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Column(children: [
          const SizedBox(height: 15),
          Text("مساعد فلكس الذكي", style: GoogleFonts.cairo(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          Expanded(child: ListView(padding: const EdgeInsets.all(20), children: [
            _msg("أهلاً بك! أنا وسيطك الذكي. كيف أساعدك اليوم في البحث عن عقارات أو مجوهرات؟", false),
          ])),
          _chatInput(),
        ]),
      ),
    );
  }
  Widget _msg(String m, bool u) => Align(alignment: u ? Alignment.centerRight : Alignment.centerLeft, child: Container(padding: const EdgeInsets.all(10), margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: u ? const Color(0xFFD4AF37) : Colors.white10, borderRadius: BorderRadius.circular(10)), child: Text(m, style: TextStyle(color: u ? Colors.black : Colors.white, fontSize: 13))));
  Widget _chatInput() => Padding(padding: const EdgeInsets.all(15), child: Row(children: [Expanded(child: TextField(decoration: InputDecoration(hintText: "اسأل البوت...", filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))))), IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: Color(0xFFD4AF37)))]));
}

// 🏠 الصفحة الرئيسية (سيرش + سلايدر)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: [
    Padding(padding: const EdgeInsets.all(15), child: Container(decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)), child: const TextField(decoration: InputDecoration(hintText: "بحث عن عقارات، سيارات...", prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)), border: InputBorder.none)))),
    _slider(),
    _sectionTitle("أحدث الإعلانات"),
    _itemCard("فيلا في صنعاء", "500,000 \$", Icons.home),
    _itemCard("سيارة تويوتا 2024", "40,000 \$", Icons.directions_car),
  ]);
  Widget _slider() => Container(height: 140, margin: const EdgeInsets.all(15), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.black, Color(0xFFD4AF37)]), borderRadius: BorderRadius.circular(15)), child: const Center(child: Text("إعلانات فلكس المميزة", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))));
  Widget _sectionTitle(String t) => Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  Widget _itemCard(String t, String p, IconData i) => ListTile(leading: Icon(i, color: const Color(0xFFD4AF37)), title: Text(t), trailing: Text(p, style: const TextStyle(color: Colors.green)));
}

// 🛒 المتجر بكامل أقسامه
class StoreGrid extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final VoidCallback onAdd;
  StoreGrid({required this.categories, required this.onAdd});
  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(15),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemCount: categories.length,
    itemBuilder: (context, i) => InkWell(
      onTap: onAdd,
      child: Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(categories[i]['i'], color: categories[i]['c']), Text(categories[i]['n'], style: const TextStyle(fontSize: 10))])),
    ),
  );
}

// الواجهات الأخرى المدمجة
class AddPostScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("صفحة رفع الإعلانات من الهاتف")); }
class WalletScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("المحفظة المالية (كريمي/ام فلوس)")); }
class ChatListScreen extends StatelessWidget { @override Widget build(BuildContext context) => const Center(child: Text("قائمة الدردشات والوساطة")); }
class ProfilePage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  ProfilePage({required this.onThemeToggle, required this.isDarkMode});
  @override Widget build(BuildContext context) => ListView(children: [
    const ListTile(leading: CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, color: Colors.black)), title: Text("حسابي الموثق"), subtitle: Text("صنعاء، اليمن")),
    SwitchListTile(title: const Text("الوضع الليلي"), value: isDarkMode, onChanged: (v) => onThemeToggle()),
    const ListTile(leading: Icon(Icons.verified), title: Text("توثيق الهوية (Flex Identity)")),
  ]);
}
