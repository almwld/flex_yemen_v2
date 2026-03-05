import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _sliderController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // سلايدر أوتوماتيكي يتحرك كل 3 ثوانٍ
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) _currentPage++; else _currentPage = 0;
      if (_sliderController.hasClients) {
        _sliderController.animateToPage(_currentPage, 
          duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildSearchHeader(), // البحث الاحترافي
          
          _buildMainSlider(), // 1. السلايدر الرئيسي (5 عروض متحركة)
          
          _buildWeeklyDeals(), // 2. العروض الأسبوعية (توقيت تنازلي محاكى)

          _buildGridCategories(), // الأقسام

          _buildOfferBanners(), // 3. بنرات العروض الجانبية (ثنائية)

          _buildFlashSaleSection(), // 4. تخفيضات كبرى (Scroll Horizontal)

          _buildBigPromoBanner(), // 5. بنر إعلاني ضخم أسفل الصفحة

          const SizedBox(height: 120),
        ],
      ),
    );
  }

  // 1. السلايدر الرئيسي الاحترافي
  Widget _buildMainSlider() => Container(
    height: 200,
    child: PageView.builder(
      controller: _sliderController,
      onPageChanged: (i) => setState(() => _currentPage = i),
      itemCount: 5,
      itemBuilder: (context, i) => _buildSliderItem(i),
    ),
  );

  Widget _buildSliderItem(int index) {
    List<String> titles = ["مهرجان الذهب العالمي", "أقوى عروض السيارات", "تخفيضات الفنادق", "شحن ألعاب فوري", "جديد عالم الأزياء"];
    List<Color> colors = [Color(0xFFD4AF37), Colors.blue, Colors.teal, Colors.indigo, Colors.pink];
    
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [colors[index], Colors.black87], begin: Alignment.topLeft),
        boxShadow: [BoxShadow(color: colors[index].withOpacity(0.3), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Stack(
        children: [
          Positioned(right: 20, top: 40, child: Icon(Icons.star, color: Colors.white24, size: 100)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("عروض حصرية", style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text(titles[index], style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                  child: Text("تسوق الآن"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. العروض الأسبوعية
  Widget _buildWeeklyDeals() => Container(
    padding: EdgeInsets.all(15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("العروض الأسبوعية 📅", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: Text("تنتهي خلال 03:22:15", style: TextStyle(color: Colors.white, fontSize: 10)),
            )
          ],
        ),
      ],
    ),
  );

  // 3. بنرات العروض (مزدوجة)
  Widget _buildOfferBanners() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: [
        Expanded(child: _miniBanner("تخفيضات الفضة", "خصم 30%", Colors.blueGrey)),
        SizedBox(width: 15),
        Expanded(child: _miniBanner("قسم العطور", "اشتري 1 واحصل على 1", Colors.deepPurple)),
      ],
    ),
  );

  Widget _miniBanner(String t, String s, Color c) => Container(
    height: 100,
    decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(15), border: Border.all(color: c.withOpacity(0.5))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(t, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(s, style: TextStyle(color: c, fontSize: 12)),
      ],
    ),
  );

  // 4. فلاش سيل (Flash Sale)
  Widget _buildFlashSaleSection() => Column(
    children: [
      _buildSectionHeader("تخفيضات كبرى 🔥"),
      SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: 5,
          itemBuilder: (context, i) => Container(
            width: 140,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Expanded(child: Icon(Icons.image, color: Colors.white24)),
                Text("منتج تخفيض $i"),
                Text("40% OFF", style: TextStyle(color: Colors.red, fontSize: 10)),
              ],
            ),
          ),
        ),
      )
    ],
  );

  // 5. بنر إعلاني ضخم
  Widget _buildBigPromoBanner() => Container(
    width: double.infinity,
    height: 150,
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [Colors.black, Colors.grey[900]!]),
      border: Border.all(color: Color(0xFFD4AF37).withOpacity(0.5)),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.stars, color: Color(0xFFD4AF37), size: 40),
          Text("اشترك في عضوية FLEX الذهبية", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          Text("واحصل على شحن مجاني لجميع الطلبات", style: TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    ),
  );

  // الدوال المساعدة (البحث، الأقسام، العناوين)
  Widget _buildSearchHeader() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: "بحث سريع...",
        prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    ),
  );

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text("عرض الكل", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12))]),
  );

  Widget _buildGridCategories() => GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 4,
    padding: EdgeInsets.symmetric(horizontal: 10),
    children: [
      _catIcon(Icons.restaurant, "مطاعم"),
      _catIcon(Icons.checkroom, "أزياء"),
      _catIcon(Icons.videogame_asset, "ألعاب"),
      _catIcon(Icons.hotel, "فنادق"),
    ],
  );

  Widget _catIcon(IconData i, String l) => Column(children: [Icon(i, color: Color(0xFFD4AF37)), Text(l, style: TextStyle(fontSize: 10))]);
}
