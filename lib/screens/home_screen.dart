import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/glass_search_bar.dart';
import '../widgets/live_news_ticker.dart';
import '../widgets/stories_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () => setState(() => isConnected = true));
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            LiveNewsTicker(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(child: GlassSearchBar()),
                  SizedBox(width: 10),
                  Icon(isConnected ? Icons.cloud_done : Icons.cloud_sync, color: isConnected ? Colors.green : Colors.orange),
                ],
              ),
            ),
            BusinessStories(),
            _buildPlaceholderSection("السلايدر الإعلاني"),
            _buildPlaceholderSection("أقسام المتجر"),
            _buildPlaceholderSection("المنتجات الحقيقية"),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderSection(String title) => Container(
    height: 150,
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
    child: Center(child: Text(title)),
  );
}
