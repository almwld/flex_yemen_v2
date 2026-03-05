import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  bool isConnected = false;
  List<dynamic> products = [];
  List<dynamic> banners = [];

  @override
  void initState() {
    super.initState();
    _startDelayedConnection();
  }

  // الخطوة السحرية: الانتظار 10 ثوانٍ قبل جلب البيانات
  void _startDelayedConnection() async {
    await Future.delayed(Duration(seconds: 10));
    try {
      final productData = await supabase.from('products').select().limit(4);
      final bannerData = await supabase.from('banners').select();
      
      setState(() {
        products = productData;
        banners = bannerData;
        isConnected = true;
      });
    } catch (e) {
      print("خطأ في الاتصال: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 800),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            _buildSearch(),
            
            // إذا لم يتصل بعد، اعرض سلايدر "انتظار" احترافي
            !isConnected ? _buildSkeletonSlider() : _buildRealSlider(),

            _buildSectionTitle("الأقسام الذكية"),
            _buildAnimatedGrid(),

            _buildSectionTitle("وصل حديثاً 💎"),
            // إذا لم يتصل بعد، اعرض مربعات "انتظار"
            !isConnected ? _buildSkeletonProducts() : _buildRealProducts(),
            
            if(!isConnected) 
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(child: Text("جاري تحديث البيانات من السحابة... ☁️", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10))),
              ),
          ],
        ),
      ),
    );
  }

  // --- واجهات الانتظار (Skeletons) ---

  Widget _buildSkeletonSlider() => Container(
    height: 180,
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [Colors.white10, Colors.white24]),
    ),
    child: Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
  );

  Widget _buildSkeletonProducts() => GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    padding: EdgeInsets.all(15),
    mainAxisSpacing: 10, crossAxisSpacing: 10,
    children: List.generate(4, (i) => Container(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
    )),
  );

  // --- واجهات البيانات الحقيقية ---

  Widget _buildRealSlider() => Container(
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

  Widget _buildRealProducts() => GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(15),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, mainAxisSpacing: 10, crossAxisSpacing: 10),
    itemCount: products.length,
    itemBuilder: (context, i) => Container(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Expanded(child: Image.network(products[i]['image_url'] ?? "")),
          Text(products[i]['name'] ?? ""),
          Text("${products[i]['price']} RY", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );

  // المكونات الثابتة
  Widget _buildSearch() => Padding(padding: EdgeInsets.all(16), child: TextField(decoration: InputDecoration(hintText: "ابحث في Flex Yemen...", prefixIcon: Icon(Icons.search, color: Color(0xFFD4AF37)), filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none))));
  Widget _buildSectionTitle(String t) => Padding(padding: EdgeInsets.all(16), child: Text(t, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  Widget _buildAnimatedGrid() => Container(height: 80, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Icon(Icons.restaurant), Icon(Icons.diamond), Icon(Icons.videogame_asset), Icon(Icons.hotel)]));
}
