import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // تعريف الأقسام الرئيسية للمتجر
  final List<Map<String, dynamic>> storeTabs = [
    {"n": "المطاعم", "i": Icons.restaurant},
    {"n": "الذهب", "i": Icons.diamond},
    {"n": "ألعاب", "i": Icons.videogame_asset},
    {"n": "الفنادق", "i": Icons.hotel},
    {"n": "أزياء", "i": Icons.checkroom},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: storeTabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. شريط التبويبات العلوي (ثابت)
        TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Color(0xFFD4AF37),
          labelColor: Color(0xFFD4AF37),
          unselectedLabelColor: Colors.grey,
          tabs: storeTabs.map((tab) => Tab(
            icon: Icon(tab['i'], size: 20),
            text: tab['n'],
          )).toList(),
        ),

        // 2. محتوى المتجر المتغير بناءً على التبويب
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildFoodSection(),    // قسم المطاعم
              _buildGoldSection(),    // قسم الذهب
              _buildGamingSection(),  // قسم الألعاب
              _buildHotelSection(),   // قسم الفنادق
              _buildFashionSection(), // قسم الأزياء
            ],
          ),
        ),
      ],
    );
  }

  // --- بناء الأقسام (بيانات حقيقية لكل نوع) ---

  Widget _buildFoodSection() => ListView(
    padding: EdgeInsets.all(15),
    children: [
      _storeCard("مطعم شيباني", "أشهى المأكولات اليمنية", "4.8", "https://via.placeholder.com/100", "مفتوح"),
      _storeCard("بيتزا هت - صنعاء", "عرض الغداء: بيتزا وسط + كولا", "4.5", "https://via.placeholder.com/100", "مزدحم"),
    ],
  );

  Widget _buildGoldSection() => GridView.builder(
    padding: EdgeInsets.all(15),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75, mainAxisSpacing: 10, crossAxisSpacing: 10),
    itemCount: 4,
    itemBuilder: (context, i) => _productCard("طقم ذهب عيار 21", "2,500,000 RY", "مجوهرات اليافعي"),
  );

  Widget _buildGamingSection() => ListView(
    padding: EdgeInsets.all(15),
    children: [
      _gameChargeTile("660 UC - PUBG Mobile", "12.5 USD", Icons.bolt),
      _gameChargeTile("1000 Diamond - Free Fire", "9.0 USD", Icons.local_fire_department),
    ],
  );

  Widget _buildHotelSection() => ListView(
    padding: EdgeInsets.all(15),
    children: [
      _storeCard("فندق موفنبيك", "جناح ملكي - إطلالة جبلية", "4.9", "https://via.placeholder.com/100", "متوفر"),
    ],
  );

  Widget _buildFashionSection() => Center(child: Text("قسم الأزياء قيد التحديث..."));

  // --- المكونات المشتركة ---

  Widget _storeCard(String name, String desc, String rate, String img, String status) => Card(
    margin: EdgeInsets.only(bottom: 15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      leading: Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(10))),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(desc, style: TextStyle(fontSize: 12)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.star, color: Colors.amber, size: 15), Text(rate)]),
          Text(status, style: TextStyle(color: Colors.green, fontSize: 10)),
        ],
      ),
    ),
  );

  Widget _productCard(String name, String price, String store) => Container(
    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Container(decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.vertical(top: Radius.circular(15))))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1),
              Text(price, style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11)),
              Text(store, style: TextStyle(color: Colors.grey, fontSize: 9)),
            ],
          ),
        )
      ],
    ),
  );

  Widget _gameChargeTile(String name, String price, IconData icon) => ListTile(
    leading: CircleAvatar(backgroundColor: Colors.indigo, child: Icon(icon, color: Colors.white)),
    title: Text(name),
    subtitle: Text("شحن فوري برقم الآيدي"),
    trailing: Text(price, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
  );
}
