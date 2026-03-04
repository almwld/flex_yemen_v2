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

  // قاعدة بيانات وهمية تحاكي الحقيقية لجلب المعلومات
  final Map<String, dynamic> appDatabase = {
    "مجوهرات": {"المنتج": "طقم ذهب عيار 21", "السعر": "1,200 \$", "التاجر": "مجوهرات الصنعاني"},
    "فضيات يمنية": {"المنتج": "خاتم عقيق فضة", "السعر": "25,000 RY", "التاجر": "فضيات عدن"},
  };

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
        db: appDatabase,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        onAddToCart: () => setState(() => cartCount++),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final bool isDarkMode;
  final int cartCount;
  final Map<String, dynamic> db;
  final VoidCallback onThemeToggle;
  final VoidCallback onAddToCart;
  MainNavigation({required this.isDarkMode, required this.cartCount, required this.db, required this.onThemeToggle, required this.onAddToCart});
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("FLEX YEMEN PRO", style: GoogleFonts.cairo(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD4AF37),
        onPressed: () => _showSmartBot(context),
        child: const Icon(Icons.auto_awesome, color: Colors.black, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "المتجر"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
        selectedItemColor: const Color(0xFFD4AF37),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 1) return _buildStoreGrid();
    return Center(child: Text("مرحباً بك في فلكس يمن\nاستخدم البوت الذكي للحصول على المعلومات", textAlign: TextAlign.center, style: GoogleFonts.cairo(fontSize: 16)));
  }

  Widget _buildStoreGrid() => GridView.count(
    crossAxisCount: 2, padding: const EdgeInsets.all(15), children: [
      _catCard("مجوهرات", Icons.diamond, Colors.blue),
      _catCard("فضيات يمنية", Icons.shutter_speed, Colors.grey),
    ],
  );

  Widget _catCard(String n, IconData i, Color c) => Card(
    color: const Color(0xFF1A1A1A),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(i, color: c, size: 40),
      Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
    ]),
  );

  void _showSmartBot(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(color: Color(0xFF151515), borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Column(children: [
          const SizedBox(height: 10),
          Text("مساعد فلكس (مرتبط بقاعدة البيانات)", style: GoogleFonts.cairo(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          Expanded(child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _botMsg("أهلاً! أنا مبرمج لجلب كافة المعلومات. عن ماذا تبحث؟"),
              _userMsg("أريد معلومات عن الفضيات."),
              _botMsg("بناءً على قاعدة البيانات:\n- المنتج: ${widget.db['فضيات يمنية']['المنتج']}\n- السعر: ${widget.db['فضيات يمنية']['السعر']}\n- التاجر: ${widget.db['فضيات يمنية']['التاجر']}"),
              _botMsg("هل تريدني أن أوصلك بالتاجر الآن؟"),
            ],
          )),
          _inputArea(),
        ]),
      ),
    );
  }

  Widget _botMsg(String m) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)), child: Text(m, style: const TextStyle(color: Colors.white70, fontSize: 13)));
  Widget _userMsg(String m) => Align(alignment: Alignment.centerRight, child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: Text(m, style: const TextStyle(color: Colors.white))));
  Widget _inputArea() => Padding(padding: const EdgeInsets.all(15), child: Row(children: [Expanded(child: TextField(decoration: InputDecoration(hintText: "اسأل عن أي منتج...", filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))))), const SizedBox(width: 10), const CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.send, color: Colors.black))]));
}
