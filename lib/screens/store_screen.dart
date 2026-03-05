import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final List<String> categories = ["الكل", "ذهب عيار 21", "سيارات", "عقارات", "إلكترونيات"];
  int selectedCat = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildFilterBar(), // بار الأقسام العلوي
          Expanded(
            child: AnimationLimiter(
              child: GridView.builder(
                padding: EdgeInsets.all(15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: 10, // عدد تجريبي للمنتجات
                itemBuilder: (context, index) => _buildAnimatedProductCard(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // بار الفلترة الأفقي
  Widget _buildFilterBar() => Container(
    height: 60,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, i) => GestureDetector(
        onTap: () => setState(() => selectedCat = i),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: selectedCat == i ? Color(0xFFD4AF37) : Colors.white10,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(categories[i], 
              style: TextStyle(color: selectedCat == i ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
      ),
    ),
  );

  // كرت المنتج مع الأنيميشن
  Widget _buildAnimatedProductCard(int index) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: const Duration(milliseconds: 500),
      columnCount: 2,
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Center(child: Icon(Icons.image, color: Color(0xFFD4AF37), size: 40)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("طقم ملكي - عيار 21", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("صنعاء - بيت بوس", style: TextStyle(color: Colors.grey, fontSize: 10)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2,450,000", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
                          Text("RY", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
