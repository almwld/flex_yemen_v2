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
      MapsScreen(), 
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
        title: Text("FLEX YEMEN", style: GoogleFonts.cairo(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 18)),
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
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(Icons.home_filled, "الرئيسية", 0),
              _navItem(Icons.map_outlined, "الخرائط", 1),
              _navItem(Icons.storefront_outlined, "المتجر", 2),
            ],
          )),
          const SizedBox(width: 50),
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
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey, size: 22),
      Text(label, style: GoogleFonts.cairo(fontSize: 8, fontWeight: FontWeight.bold, color: _currentIndex == index ? const Color(0xFFD4AF37) : Colors.grey)),
    ]),
  );
}

// --- 🏠 1. واجهة الرئيسية (محتوى عقارات وسيارات يمني) ---
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(15),
    children: [
      Text("الأكثر رواجاً في اليمن", style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 15),
      _itemCard("فيلا فاخرة - حي حدة", "650,000 $", "صنعاء", Icons.home_work, Colors.blue),
      _itemCard("تويوتا لاندكروزر 2024", "98,000 $", "عدن", Icons.directions_car, Colors.red),
      _itemCard("أرض استثمارية - المطار", "220,000 $", "صنعاء", Icons.landscape, Colors.green),
    ],
  );
  Widget _itemCard(String t, String p, String l, IconData i, Color c) => Card(
    margin: const EdgeInsets.only(bottom: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: const Color(0xFF1A1A1A),
    child: ListTile(
      leading: CircleAvatar(backgroundColor: c.withOpacity(0.1), child: Icon(i, color: c)),
      title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(l),
      trailing: Text(p, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
    ),
  );
}

// --- 🏪 2. واجهة المتجر (أقسام كاملة) ---
class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});
  final List<Map<String, dynamic>> categories = [
    {"n": "سوبر ماركت", "i": Icons.shopping_basket, "c": Colors.green},
    {"n": "مطاعم", "i": Icons.restaurant, "c": Colors.orange},
    {"n": "تقنيات", "i": Icons.devices, "c": Colors.blue},
    {"n": "أزياء", "i": Icons.checkroom, "c": Colors.purple},
    {"n": "ألعاب", "i": Icons.videogame_asset, "c": Colors.red},
    {"n": "عطارة", "i": Icons.eco, "c": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.all(15),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
    itemCount: categories.length,
    itemBuilder: (context, i) => InkWell(
      onTap: onAdd,
      child: Container(
        decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(categories[i]['i'], color: categories[i]['c'], size: 30),
          Text(categories[i]['n'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ]),
      ),
    ),
  );
}

// --- 📍 3. واجهة الخرائط ---
class MapsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage("https://www.mapsofworld.com/yemen/maps/yemen-map.jpg"), fit: BoxFit.cover, opacity: 0.3)),
    child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.location_on, size: 50, color: Colors.red),
      Text("خريطة العقارات والخدمات", style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold)),
      const Text("جاري تحميل المواقع القريبة منك..."),
    ])),
  );
}

// --- ➕ 4. واجهة إضافة إعلان ---
class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(children: [
      const Icon(Icons.add_a_photo, size: 80, color: Color(0xFFD4AF37)),
      const SizedBox(height: 20),
      const TextField(decoration: InputDecoration(labelText: "عنوان الإعلان (مثلاً: شقة للإيجار)", border: OutlineInputBorder())),
      const SizedBox(height: 10),
      const TextField(decoration: InputDecoration(labelText: "السعر المتوقع", border: OutlineInputBorder())),
      const SizedBox(height: 20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)), onPressed: () {}, child: const Text("نشر الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ]),
  );
}

// --- 💳 5. واجهة المحفظة ---
class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Colors.orangeAccent]), borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          const Text("رصيدك الحالي", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          Text("250,000 RY", style: GoogleFonts.cairo(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
        ]),
      ),
      const SizedBox(height: 20),
      ListTile(leading: const Icon(Icons.history), title: const Text("سجل العمليات"), trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
      ListTile(leading: const Icon(Icons.payment), title: const Text("شحن رصيد (كريمي / ام فلوس)"), trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
    ]),
  );
}

// --- 💬 6. واجهة الدردشة ---
class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: [
    _chatTile("الدعم الفني", "مرحباً بك، كيف نخدمك؟", "10:30 AM", true),
    _chatTile("الوسيط العقاري", "هل الفيلا لا تزال متاحة؟", "09:15 AM", false),
    _chatTile("خدمة فلكس برايم", "تم تفعيل اشتراكك السنوي", "أمس", false),
  ]);
  Widget _chatTile(String n, String m, String t, bool u) => ListTile(
    leading: const CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, color: Colors.black)),
    title: Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(m),
    trailing: Column(children: [Text(t, style: const TextStyle(fontSize: 10)), if (u) const CircleAvatar(radius: 5, backgroundColor: Colors.red)]),
  );
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: const [
    Center(child: CircleAvatar(radius: 50, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black))),
    SizedBox(height: 20),
    ListTile(leading: Icon(Icons.lock_outline), title: Text("الأمان والخصوصية")),
    ListTile(leading: Icon(Icons.notifications_outlined), title: Text("الإشعارات")),
    ListTile(leading: Icon(Icons.info_outline), title: Text("عن فلكس يمن (الإصدار 1.2.0)")),
  ]);
}
