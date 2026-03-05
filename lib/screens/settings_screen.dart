import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مركز التحكم والأمان"), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _buildUserCard(),
          SizedBox(height: 20),
          
          _buildCategoryTitle("التحقق من الهوية (KYC)"),
          _buildActionCard(Icons.badge_outlined, "توثيق الحساب", "ارفع هويتك لزيادة سقف العمليات", Colors.orange, () => _showKYCDialog()),

          _buildCategoryTitle("إعدادات الأمان المتقدمة"),
          _buildSettingItem(Icons.lock_reset, "تغيير كلمة المرور", "آخر تغيير: منذ شهر"),
          _buildSettingItem(Icons.phonelink_lock, "المصادقة الثنائية (2FA)", "غير مفعلة", trailing: Switch(value: false, onChanged: (v){})),
          _buildSettingItem(Icons.devices, "الأجهزة النشطة", "جهاز واحد حالياً"),

          _buildCategoryTitle("التفضيلات والعملة"),
          _buildSettingItem(Icons.language, "لغة التطبيق", "العربية"),
          _buildSettingItem(Icons.monetization_on_outlined, "العملة الأساسية", "ريال يمني - RY"),

          _buildCategoryTitle("النظام والدعم"),
          _buildSettingItem(Icons.dark_mode_outlined, "الوضع الداكن", "تلقائي"),
          _buildSettingItem(Icons.help_outline, "مركز المساعدة", ""),
          
          SizedBox(height: 40),
          _buildLogoutButton(),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildUserCard() => Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)]),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color(0xFFD4AF37).withOpacity(0.2)),
    ),
    child: Row(
      children: [
        CircleAvatar(radius: 35, backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person, size: 35, color: Colors.black)),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("محمد المولد", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(supabase.auth.currentUser?.email ?? "user@flexyemen.com", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        Spacer(),
        Icon(Icons.qr_code, color: Color(0xFFD4AF37)),
      ],
    ),
  );

  Widget _buildCategoryTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
    child: Text(title, style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
  );

  Widget _buildSettingItem(IconData icon, String title, String subtitle, {Widget? trailing}) => Card(
    color: Colors.white.withOpacity(0.02),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: TextStyle(fontSize: 14)),
      subtitle: subtitle.isEmpty ? null : Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey)),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
    ),
  );

  Widget _buildActionCard(IconData icon, String title, String sub, Color col, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(15), border: Border.all(color: col.withOpacity(0.3))),
      child: Row(
        children: [
          Icon(icon, color: col),
          SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold)), Text(sub, style: TextStyle(fontSize: 11, color: Colors.grey))])),
          Icon(Icons.upload_file, color: col),
        ],
      ),
    ),
  );

  Widget _buildLogoutButton() => ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.withOpacity(0.1), foregroundColor: Colors.red, minimumSize: Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    onPressed: () => supabase.auth.signOut(),
    child: Text("تسجيل خروج آمن"),
  );

  void _showKYCDialog() {
    showModalBottomSheet(context: context, builder: (c) => Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("توثيق الهوية KYC", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("لضمان أمان عملياتك المالية والذهب، يرجى رفع صورة واضحة لبطاقتك الشخصية.", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 20),
          ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.camera_alt), label: Text("التقاط صورة الهوية"), style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50))),
          SizedBox(height: 10),
        ],
      ),
    ));
  }
}
