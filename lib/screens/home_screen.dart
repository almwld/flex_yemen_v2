import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _sliderController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> allServices = [
    {"n": "ذهب", "i": Icons.diamond, "c": Color(0xFFD4AF37)},
    {"n": "سيارات", "i": Icons.directions_car, "c": Colors.blue},
    {"n": "عقارات", "i": Icons.home_work, "c": Colors.green},
    {"n": "مطاعم", "i": Icons.restaurant, "c": Colors.orange},
    {"n": "أزياء", "i": Icons.checkroom, "c": Colors.pink},
    {"n": "شحن ألعاب", "i": Icons.videogame_asset, "c": Colors.indigo},
    {"n": "فنادق", "i": Icons.hotel, "c": Colors.teal},
    {"n": "إلكترونيات", "i": Icons.devices, "c": Colors.purple},
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 4) _currentPage++; else _currentPage = 0;
      if (_sliderController.hasClients) {
        _sliderController.animateToPage(_currentPage, duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildSearch(), // الخطوة 11: البحث الذكي مع الفلترة
          
          _buildGridCategories(), // الخطوة 12: شبكة الخدمات السريعة

          const SizedBox(height: 20),
          _buildAutoSlider(), // الخطوة 13: سلايدر إعلانات تفاعلي

          // الخطوة 14: قسم "توصيات الذكاء الاصطناعي" (AI Recommendations)
          _buildSectionTitle("مقترح لك بالذكاء الاصطناعي 🤖"),
          _buildAiSuggestions(),

          // الخطوة 15: قصص (Stories) التجار والمحلات (مثل إنستجرام)
          _buildMerchantStories(),

          // الخطوة 16: بنر "مزادات مباشرة" (Live Auctions)
          _buildLiveAuctions(),

          // الخطوة 17: قسم "الماركات العالمية" (Brands Logo Slider)
          _buildSectionTitle("أشهر الماركات 🏷️"),
          _buildBrandLogos(),

          // الخطوة 18: قسم "الخدمات الأكثر طلباً في منطقتك" (Location Based)
          _buildSectionTitle("الأكثر طلباً في صنعاء 🔥"),
          _buildHorizontalProducts(),

          // الخطوة 19: بنر "اشحن محفظتك واحصل على كاش باك"
          _buildCashbackBanner(),

          // الخطوة 20: قسم "آخر الأخبار الاقتصادية" (أسعار الصرف والذهب)
          _buildEconomyNews(),

          const SizedBox(height: 120), 
        ],
      ),
    );
  }

  // --- دوال البناء الاحترافية ---

  Widget _buildAiSuggestions() => SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: 4,
      itemBuilder: (context, i) => Container(
        width: 250,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [Colors.blue.withOpacity(0.1), Colors.purple.withOpacity(0.1)]),
          border: Border.all(color: Colors.blue.withAlpha(50)),
        ),
        child: ListTile(
          leading: Icon(Icons.auto_awesome, color: Colors.blue),
          title: Text("بناءً على بحثك عن الذهب", style: TextStyle(fontSize: 11)),
          subtitle: Text("خواتم عيار 21 متوفرة الآن", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ),
    ),
  );

  Widget _buildMerchantStories() => SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFD4AF37),
              child: CircleAvatar(radius: 28, backgroundColor: Colors.black, child: Icon(Icons.storefront, color: Colors.white)),
            ),
            Text("تاجر $i", style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    ),
  );

  Widget _buildLiveAuctions() => Container(
    margin: EdgeInsets.all(15),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.red),
    ),
    child: Row(
      children: [
        Icon(Icons.live_tv, color: Colors.red),
        SizedBox(width: 10),
        Text("مزاد مباشر: ساعة رولكس أصلية", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        Spacer(),
        Container(padding: EdgeInsets.all(5), color: Colors.red, child: Text("LIVE", style: TextStyle(fontSize: 10))),
      ],
    ),
  );

  Widget _buildBrandLogos() => SizedBox(
    height: 60,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, i) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text("BRAND $i", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
      ),
    ),
  );

  Widget _buildCashbackBanner() => Container(
    margin: EdgeInsets.all(15),
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(colors: [Color(0xFFD4AF37), Colors.orange]),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.account_balance_wallet, color: Colors.black),
        SizedBox(width: 10),
        Text("اشحن محفظتك الآن واحصل على 5% كاش باك", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _buildEconomyNews() => Container(
    margin: EdgeInsets.all(15),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("أسعار الصرف والذهب اليوم"), Icon(Icons.trending_up, color: Colors.green)]),
        Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("صرف الدولار: 1650"), Text("جرام الذهب: 45000")]),
      ],
    ),
  );

  // الدوال السابقة (Search, Grid, Slider, Title) تبقى كما هي مع تحسينات طفيفة
  Widget _buildSearch() => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: TextField(
              decoration: InputDecoration(hintText: "ابحث عن كل ما تحتاجه...", border: InputBorder.none, icon: Icon(Icons.search, color: Color(0xFFD4AF37))),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.filter_list, color: Colors.black),
        )
      ],
    ),
  );

  Widget _buildGridCategories() => GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: 10),
    itemCount: allServices.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.85, mainAxisSpacing: 10, crossAxisSpacing: 10),
    itemBuilder: (context, i) => Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: allServices[i]['c'].withOpacity(0.1), borderRadius: BorderRadius.circular(15), border: Border.all(color: allServices[i]['c'].withOpacity(0.2))),
          child: Icon(allServices[i]['i'], color: allServices[i]['c'], size: 24),
        ),
        SizedBox(height: 5),
        Text(allServices[i]['n'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _buildAutoSlider() => Container(
    height: 160,
    child: PageView.builder(
      controller: _sliderController,
      itemCount: 5,
      itemBuilder: (context, i) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: LinearGradient(colors: [Color(0xFFD4AF37), Colors.black])),
        child: Center(child: Text("إعلان مميز ${i+1}", style: TextStyle(color: Colors.white))),
      ),
    ),
  );

  Widget _buildSectionTitle(String title) => Padding(
    padding: EdgeInsets.all(16),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text("عرض الكل", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12))]),
  );

  Widget _buildHorizontalProducts() => SizedBox(
    height: 160,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, i) => Container(
        width: 130, margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
        child: Center(child: Text("منتج $i")),
      ),
    ),
  );
}
