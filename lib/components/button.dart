// my_button.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _getLocationAndSend();
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 2, 45, 80),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getLocationAndSend() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Envoi de la localisation à l'administrateur (exemple fictif)
      _sendLocationToAdmin(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }

  void _sendLocationToAdmin(double latitude, double longitude) async {
    // Remplacez l'URL ci-dessous par l'URL de votre serveur d'administration
    var url = Uri.parse('https://sore-gray-cygnet-wear.cyclic.app');
    
    // Remplacez les noms des paramètres et le format des données selon les besoins de votre serveur
    var response = await http.post(url, body: {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    });

    if (response.statusCode == 200) {
      print('Localisation envoyée avec succès à l\'administrateur');
    } else {
      print('Échec de l\'envoi de la localisation à l\'administrateur');
    }
  }
}
