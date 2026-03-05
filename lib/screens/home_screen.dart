import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatelessWidget {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildSearch(),
            _buildDynamicSlider(), // جلب من جدول Banners
            _buildSectionTitle("الأقسام المميزة"),
            _buildGridCategories(),
            _buildSectionTitle("وصل حديثاً 💎"),
            _buildDynamicProducts(), // جلب من جدول Products
          ],
        ),
      ),
    );
  }

  // جلب السلايدر من سوبابيس
  Widget _buildDynamicSlider() {
    return FutureBuilder(
      future: supabase.from('banners').select(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Container(height: 180, child: Center(child: CircularProgressIndicator()));
        final banners = snapshot.data as List;
        return Container(
          height: 180,
          child: PageView.builder(
            itemCount: banners.length,
            itemBuilder: (context, i) => Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage(banners[i]['image_url']), fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }

  // جلب المنتجات من سوبابيس
  Widget _buildDynamicProducts() {
    return FutureBuilder(
      future: supabase.from('products').select().limit(4),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        final products = snapshot.data as List;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: products.length,
          itemBuilder: (context, i) => _productCard(products[i]),
        );
      },
    );
  }

  Widget _productCard(Map data) => Container(
    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Expanded(child: data['image_url'] != null ? Image.network(data['image_url']) : Icon(Icons.image)),
        Text(data['name'] ?? "منتج بدون اسم"),
        Text("${data['price']} RY", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _buildSearch() => Padding(padding: EdgeInsets.all(16), child: TextField(decoration: InputDecoration(hintText: "ابحث في Flex Yemen...", prefixIcon: Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))));
  Widget _buildSectionTitle(String t) => Padding(padding: EdgeInsets.all(16), child: Text(t, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  Widget _buildGridCategories() => Container(height: 80, child: Center(child: Text("المطاعم | الذهب | الألعاب | الفنادق")));
}
