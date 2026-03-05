import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationEnabled = true;
  String selectedCurrency = "RY"; // ريال يمني
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            
            _buildSectionHeader("تفضيلات النظام"),
            _buildSettingTile(Icons.language, "اللغة", "العربية"),
            _buildSettingTile(Icons.payments_outlined, "العملة الافتراضية", selectedCurrency, onTap: _showCurrencyPicker),
            _buildSwitchTile(Icons.notifications_active_outlined, "التنبيهات الحية", isNotificationEnabled, (v) => setState(() => isNotificationEnabled = v)),
            
            _buildSectionHeader("الأمان والتوثيق"),
            _buildSettingTile(Icons.verified_user_outlined, "توثيق الحساب (KYC)", "لم يتم التوثيق", color: Colors.orange),
            _buildSettingTile(Icons.lock_outline, "تغيير كلمة المرور", ""),
            _buildSettingTile(Icons.fingerprint, "قفل التطبيق بالبصمة", "مفعل"),

            _buildSectionHeader("الدعم والمعلومات"),
            _buildSettingTile(Icons.info_outline, "عن Flex Yemen", "v2.0.0"),
            _buildSettingTile(Icons.description_outlined, "الشروط والأحكام", ""),
            _buildSettingTile(Icons.contact_support_outlined, "تواصل مع الإدارة", ""),

            const SizedBox(height: 30),
            _buildLogoutButton(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    child: Row(
      children: [
        CircleAvatar(radius: 40, backgroundColor: const Color(0xFFD4AF37), child: const Icon(Icons.person, size: 40, color: Colors.black)),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("محمد المولد", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(supabase.auth.currentUser?.email ?? "flex_user@yemen.com", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(5)), child: const Text("حساب موثق ✔", style: TextStyle(color: Colors.green, fontSize: 10))),
          ],
        )
      ],
    ),
  );

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
    child: Align(alignment: Alignment.centerRight, child: Text(title, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))),
  );

  Widget _buildSettingTile(IconData icon, String title, String value, {VoidCallback? onTap, Color? color}) => ListTile(
    onTap: onTap,
    leading: Icon(icon, color: color ?? Colors.white70),
    title: Text(title),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ],
    ),
  );

  Widget _buildSwitchTile(IconData icon, String title, bool value, Function(bool) onChanged) => SwitchListTile(
    secondary: Icon(icon, color: Colors.white70),
    title: Text(title),
    value: value,
    activeColor: const Color(0xFFD4AF37),
    onChanged: onChanged,
  );

  Widget _buildLogoutButton() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red.withOpacity(0.1), foregroundColor: Colors.red, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: () async => await supabase.auth.signOut(),
      child: const Text("تسجيل الخروج"),
    ),
  );

  void _showCurrencyPicker() {
    showModalBottomSheet(context: context, builder: (c) => Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text("ريال يمني (RY)"), onTap: () { setState(() => selectedCurrency = "RY"); Navigator.pop(context); }),
          ListTile(title: const Text("دولار أمريكي (USD)"), onTap: () { setState(() => selectedCurrency = "USD"); Navigator.pop(context); }),
          ListTile(title: const Text("ريال سعودي (SAR)"), onTap: () { setState(() => selectedCurrency = "SAR"); Navigator.pop(context); }),
        ],
      ),
    ));
  }
}
