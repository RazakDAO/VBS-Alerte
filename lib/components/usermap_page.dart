import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';


class UserMap extends StatefulWidget {
  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {

@override
Widget build(BuildContext context) {
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(12.35,-1.516667),
      initialZoom: 8,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.app',
      ),
      RichAttributionWidget(
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
          ),
        ],
      ),
    ],
  );
}
}
