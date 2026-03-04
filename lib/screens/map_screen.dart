import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(15.3694, 44.1910), // صنعاء
        initialZoom: 6.0,
        maxZoom: 18.0,
        minZoom: 5.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.flexyemen.app',
        ),
        MarkerLayer(
          markers: [
            _buildMarker(15.3694, 44.1910, "صنعاء"),
            _buildMarker(12.7855, 45.0185, "عدن"),
            _buildMarker(13.5775, 44.0175, "تعز"),
            _buildMarker(14.7909, 42.9709, "الحديدة"),
            _buildMarker(14.5306, 49.1278, "المكلا"),
          ],
        ),
      ],
    );
  }

  Marker _buildMarker(double lat, double lng, String label) => Marker(
        point: LatLng(lat, lng),
        child: const Icon(Icons.location_on, color: Color(0xFFD4AF37), size: 45),
      );
}
