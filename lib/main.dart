import 'screens/identity_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/store_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/ai_bot_widget.dart';

void main() => runApp(FlexYemenApp());

class FlexYemenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFD4AF37),
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
      ),
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
  }

  // دالة تحاكي الذكاء الاصطناعي لتخمين السعر
  Future<void> _simulateAIPricing() async {
    // 1. الأنيميشن الدائري
    _rotationController.forward(from: 0.0);
    
    // 2. محاكاة فتح الكاميرا (كما فعلنا سابقاً)
    print("فتح الكاميرا...");
    await Future.delayed(Duration(seconds: 2)); // محاكاة التقاط الصورة
    
    // 3. تحليل الذكاء الاصطناعي (تخمين عشوائي بناءً على السوق)
    var products = ["طقم ذهب عيار 21", "خاتم فضة يمني", "تويوتا لاندكروزر 2023", "فيلا في حدة"];
    var estimatedPrices = ["1,200 \$", "35,000 RY", "98,000 \$", "550,000 \$"];
    int randomIndex = math.Random().nextInt(products.length);
    
    String product = products[randomIndex];
    String price = estimatedPrices[randomIndex];

    // 4. عرض النتيجة للعميل
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("AI تخمين: تم تحليل المنتج [$product]. السعر المتوقع بناءً على السوق: [$price].", style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: Colors.amber[900],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),
      MapScreen(),
      StoreScreen(),
      Center(child: Text("جاري تحليل السعر...")), // زر المنتصف
      WalletScreen(),
      ChatScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("FLEX YEMEN AI PRO", style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.notifications_none), onPressed: (){})],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButton: AnimatedBuilder(
        animation: _rotationController,
        builder: (context, child) => Transform.rotate(
          angle: _rotationController.value * 2 * math.pi,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFD4AF37),
            onPressed: _simulateAIPricing, // تم ربط الذكاء الاصطناعي هنا
            child: const Icon(Icons.psychology, color: Colors.black, size: 35), // أيقونة الذكاء
            elevation: 10,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Color(0xFF1A1A1A),
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navBtn(Icons.home_filled, "الرئيسية", 0),
              _navBtn(Icons.location_on, "الخرائط", 1),
              _navBtn(Icons.storefront, "المتجر", 2),
              SizedBox(width: 40), // مساحة للزر العائم
              _navBtn(Icons.wallet, "المحفظة", 4),
              _navBtn(Icons.forum, "دردشة", 5),
              _navBtn(Icons.person, "حسابي", 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navBtn(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Color(0xFFD4AF37) : Colors.grey, size: 26),
          Text(label, style: TextStyle(color: isSelected ? Color(0xFFD4AF37) : Colors.grey, fontSize: 9)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
