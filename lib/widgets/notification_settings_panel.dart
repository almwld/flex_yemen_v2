import 'package:flutter/material.dart';

class NotificationSettingsPanel extends StatefulWidget {
  @override
  _NotificationSettingsPanelState createState() => _NotificationSettingsPanelState();
}

class _NotificationSettingsPanelState extends State<NotificationSettingsPanel> {
  bool priceAlerts = true;
  bool securityAlerts = true;
  bool promoAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSwitch("تنبيهات تغيير الأسعار", priceAlerts, (v) => setState(() => priceAlerts = v)),
        _buildSwitch("تنبيهات الأمان والدخول", securityAlerts, (v) => setState(() => securityAlerts = v)),
        _buildSwitch("تنبيهات العروض والخصومات", promoAlerts, (v) => setState(() => promoAlerts = v)),
      ],
    );
  }

  Widget _buildSwitch(String title, bool val, Function(bool) onChange) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontSize: 14)),
      value: val,
      activeColor: Color(0xFFD4AF37),
      onChanged: onChange,
    );
  }
}
