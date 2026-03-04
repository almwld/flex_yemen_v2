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
      const Center(child: Text("خريطة اليمن الذكية - قيد التطوير")), 
      StoreScreen(onAdd: widget.onAddToCart), 
      AddPostScreen(),          
      const Center(child: Text("المحفظة المالية")), 
      const Center(child: Text("الدردشة والوساطة")), 
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
          _navItem(Icons.storefront_outlined, "المتجر", 2),
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

// 🏠 الصفحة الرئيسية
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    children: [
      _buildSearchBar(),
      _buildPromoSlider(),
      _buildSectionTitle("الفئات المميزة"),
      _buildCategories(),
      _buildSectionTitle("أحدث العروض في اليمن"),
      _buildItemCard("فيلا في حدة", "700,000 \$", "صنعاء", Icons.home),
      _buildItemCard("مارسيدس G-Class", "120,000 \$", "عدن", Icons.directions_car),
    ],
  );

  Widget _buildSearchBar() => Padding(
    padding: const EdgeInsets.all(15),
    child: Container(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
      child: const TextField(
        decoration: InputDecoration(hintText: "ابحث عن كل ما تحتاجه...", prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)), border: InputBorder.none),
      ),
    ),
  );

  Widget _buildPromoSlider() => Container(
    height: 150,
    margin: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(color: Colors.amber[900], borderRadius: BorderRadius.circular(15)),
    child: const Center(child: Text("عروض الصيف في فلكس يمن\nخصومات العقارات 20\%", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
  );

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.all(15),
    child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );

  Widget _buildCategories() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _catIcon(Icons.home, "عقارات"),
      _catIcon(Icons.car_rental, "سيارات"),
      _catIcon(Icons.phone_android, "جوالات"),
      _catIcon(Icons.work, "وظائف"),
    ],
  );

  Widget _catIcon(IconData i, String n) => Column(children: [CircleAvatar(backgroundColor: Colors.white10, child: Icon(i, color: const Color(0xFFD4AF37))), Text(n, style: const TextStyle(fontSize: 12))]);

  Widget _buildItemCard(String t, String p, String l, IconData i) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    color: const Color(0xFF1A1A1A),
    child: ListTile(leading: Icon(i, color: const Color(0xFFD4AF37)), title: Text(t), subtitle: Text(l), trailing: Text(p, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
  );
}

// 🛒 صفحة المتجر (أقسام المتجر)
class StoreScreen extends StatelessWidget {
  final VoidCallback onAdd;
  StoreScreen({required this.onAdd});
  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    padding: const EdgeInsets.all(15),
    children: [
      _storeCategory("أدوات منزلية", Icons.kitchen, Colors.orange),
      _storeCategory("ملابس وأزياء", Icons.checkroom, Colors.purple),
      _storeCategory("إلكترونيات", Icons.laptop, Colors.blue),
      _storeCategory("عطور وبخور", Icons.opacity, Colors.pink),
    ],
  );

  Widget _storeCategory(String n, IconData i, Color c) => Card(
    color: const Color(0xFF1A1A1A),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(i, size: 40, color: c),
      const SizedBox(height: 10),
      Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
      ElevatedButton(onPressed: onAdd, style: ElevatedButton.styleFrom(backgroundColor: c), child: const Text("تسوق")),
    ]),
  );
}

// 📤 صفحة الرفع (إضافة إعلان من الهاتف)
class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(children: [
      const Icon(Icons.cloud_upload_outlined, size: 80, color: Color(0xFFD4AF37)),
      const Text("أضف إعلانك الآن واصل لكل اليمن", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      const TextField(decoration: InputDecoration(labelText: "عنوان الإعلان", border: OutlineInputBorder())),
      const SizedBox(height: 10),
      const TextField(decoration: InputDecoration(labelText: "السعر بالدولار أو الريال", border: OutlineInputBorder())),
      const SizedBox(height: 10),
      ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.camera_alt), label: const Text("اختيار صور من الهاتف"), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50))),
      const Spacer(),
      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), minimumSize: const Size(double.infinity, 50)), child: const Text("نشر الإعلان", style: TextStyle(color: Colors.black))),
    ]),
  );
}

// 👤 صفحة الحساب والإعدادات
class ProfilePage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  ProfilePage({required this.onThemeToggle, required this.isDarkMode});

  @override
  Widget build(BuildContext context) => ListView(
    children: [
      const UserHeader(),
      const Divider(),
      _settingsItem("إعلاناتي", Icons.list_alt, () {}),
      _settingsItem("المفضلة", Icons.favorite_border, () {}),
      _settingsItem("توثيق الحساب", Icons.verified_user_outlined, () {}),
      _settingsItem("اللغة (العربية)", Icons.language, () {}),
      SwitchListTile(title: const Text("الوضع الليلي"), secondary: const Icon(Icons.dark_mode), value: isDarkMode, onChanged: (v) => onThemeToggle()),
      _settingsItem("اتصل بنا", Icons.support_agent, () {}),
      _settingsItem("تسجيل الخروج", Icons.logout, () {}, color: Colors.red),
    ],
  );

  Widget _settingsItem(String t, IconData i, VoidCallback o, {Color color = Colors.white}) => ListTile(
    leading: Icon(i, color: color == Colors.red ? color : const Color(0xFFD4AF37)),
    title: Text(t, style: TextStyle(color: color)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
    onTap: o,
  );
}

class UserHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Row(children: [
      const CircleAvatar(radius: 40, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 50, color: Colors.black)),
      const SizedBox(width: 20),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("المستخدم اليمني", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Text("صنعاء، اليمن", style: TextStyle(color: Colors.grey)),
        Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(5)), child: const Text("عضو بريميوم", style: TextStyle(color: Colors.amber, fontSize: 10))),
      ]),
    ]),
  );
}
