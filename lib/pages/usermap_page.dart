import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  LatLng _currentCenter = LatLng(12.35, -1.516667);
  double _currentZoom = 8.0;

  void _moveToNewLocation() {
    setState(() {
      _currentCenter =
          LatLng(13.45, -2.0); // Nouvelles coordonnées de la nouvelle position
      _currentZoom = 10.0; // Nouveau niveau de zoom
    });

    // Extraire les coordonnées à partir des variables _currentCenter
    double latitude = _currentCenter.latitude;
    double longitude = _currentCenter.longitude;

    // Exemple de lien Google Maps avec des coordonnées dans l'URL
    String googleMapsLink = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    // Extraire les coordonnées à partir du lien
    _extractCoordinatesFromLink(googleMapsLink);
  }

  void _extractCoordinatesFromLink(String googleMapsLink) {
  // Divisez le lien en fonction de ',' pour séparer la latitude et la longitude
  List<String> coordinates = googleMapsLink.split('?')[1].split('=')[1].split(',');

  // Extrait la latitude et la longitude
  double latitude = double.parse(coordinates[0]);
  double longitude = double.parse(coordinates[1]);

  print('Latitude : $latitude, Longitude : $longitude');
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte Utilisateur'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: _currentCenter,
          zoom: _currentZoom,
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
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToNewLocation,
        tooltip: 'Déplacer vers une nouvelle position',
        child: Icon(Icons.location_searching),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: UserMap(),
    ),
  );
}
