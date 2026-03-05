import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants.dart';
import 'screens/home_screen.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  runApp(const FlexYemenApp());
}

class FlexYemenApp extends StatefulWidget {
  const FlexYemenApp({super.key});
  @override
  State<FlexYemenApp> createState() => _FlexYemenAppState();
}

class _FlexYemenAppState extends State<FlexYemenApp> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        body: IndexedStack(index: _currentIndex, children: [HomeScreen(), Center(child: Text("المتجر")), Center(child: Text("الإعدادات"))]),
        bottomNavigationBar: FlexBottomNav(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i)),
      ),
    );
  }
}
