import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _sliderController = PageController();
  int _currentPage = 0;

  // قائمة الخدمات الشاملة للمتجر
  final List<Map<String, dynamic>> allServices = [
    {"n": "ذهب", "i": Icons.diamond, "c": Color(0xFFD4AF37)},
    {"n": "سيارات", "i": Icons.directions_car, "c": Colors.blue},
    {"n": "عقارات", "i": Icons.home_work, "c": Colors.green},
    {"n": "مطاعم", "i": Icons.restaurant, "c": Colors.orange},
    {"n": "أزياء", "i": Icons.checkroom, "c": Colors.pink},
    {"n": "شحن ألعاب", "i": Icons.videogame_asset, "c": Colors.indigo},
    {"n": "فنادق", "i": Icons.hotel, "c": Colors.teal},
    {"n": "إلكترونيات", "i": Icons.devices, "c": Colors.purple},
    {"n": "فضيات", "i": Icons.brightness_high, "c": Colors.blueGrey},
    {"n": "عطور", "i": Icons.opacity, "c": Colors.redAccent},
    {"n": "صيدليات", "i": Icons.local_hospital, "c": Colors.greenAccent},
    {"n": "توصيل", "i": Icons.delivery_dining, "c": Colors.deepOrange},
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
          _buildSearch(),
          
          // قسم الأقسام المطور (Grid) ليعرض كل الخدمات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: allServices.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 أيقونات في الصف الواحد
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, i) => _buildCategoryIcon(allServices[i]),
            ),
          ),

          const SizedBox(height: 20),
          _buildAutoSlider(),
          _buildSectionTitle("عروض اليوم ⚡"),
          _buildHorizontalProducts(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(Map<String, dynamic> service) => Column(
    children: [
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: service['c'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: service['c'].withOpacity(0.3)),
        ),
        child: Icon(service['i'], color: service['c'], size: 24),
      ),
      SizedBox(height: 5),
      Text(service['n'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    ],
  );

  Widget _buildSearch() => Padding(
    padding: const EdgeInsets.all(16),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
      child: TextField(
        decoration: InputDecoration(hintText: "ابحث عن مطعم، فندق، أو منتج...", border: InputBorder.none, icon: Icon(Icons.search, color: Color(0xFFD4AF37))),
      ),
    ),
  );

  // السلايدر ومنتجات العرض (كما في الكود السابق مع تحسينات طفيفة)
  Widget _buildAutoSlider() => Container(
    height: 160,
    child: PageView.builder(
      controller: _sliderController,
      itemCount: 5,
      itemBuilder: (context, i) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [Color(0xFFD4AF37), Colors.black]),
        ),
        child: Center(child: Text("إعلان الخدمة المميزة ${i+1}", style: TextStyle(color: Colors.white))),
      ),
    ),
  );

  Widget _buildSectionTitle(String title) => Padding(
    padding: EdgeInsets.all(16),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text("عرض الكل", style: TextStyle(color: Color(0xFFD4AF37)))]),
  );

  Widget _buildHorizontalProducts() => SizedBox(
    height: 160,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, i) => Container(
        width: 130, margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
        child: Center(child: Text("منتج/خدمة $i")),
      ),
    ),
  );
}
