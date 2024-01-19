import 'package:flutter/material.dart';
import 'package:vbs_alerte/components/drawer.dart';
import 'package:vbs_alerte/pages/login_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon'); // Remplacez 'app_icon' par le nom de votre icône
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAlertScreen(),
    );
  }
}

class MyAlertScreen extends StatelessWidget {
  const MyAlertScreen({Key? key}) : super(key: key);

  void goToProfilePage(BuildContext context) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 50.0),
          child: Text(
            'Vbs Alerte',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 45, 80),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: MyDrawer(
        onProfileTap: () => goToProfilePage(context),
        onSignOut: () {
          print('Déconnexion');
        },
      ),
      body: Center(
        child: MyAlertWidget(
          alertTitle: 'Titre personnalisé de l\'alerte',
        ),
      ),
    );
  }
}

class MyAlertWidget extends StatelessWidget {
  final String? alertTitle;

  MyAlertWidget({
    Key? key,
    this.alertTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 250.0,
      child: ElevatedButton(
        onPressed: () {
          NavigationUtils().handleAlertButtonPressed(context);
        },
        child: Image.asset(
          'assets/images/alarm1.png',
          width: 200.0,
          height: 200.0,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 242, 242, 242),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
        ),
      ),
    );
  }
}

class MapWebView extends StatelessWidget {
  final String url;

  MapWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showOptionsDialog(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Localisation sur la carte'),
      ),
      body: Center(
        child: Text('Contenu de la carte ou autre contenu ici...'),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choisissez une option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _sendMedicalRequest();
                  Navigator.of(context).pop();
                },
                child: Text('Demande de soins médicaux'),
              ),
              ElevatedButton(
                onPressed: () {
                  _sendDangerSignal();
                  Navigator.of(context).pop();
                },
                child: Text('Signal de danger'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMedicalRequest() {
    // Logique pour envoyer la demande de soins médicaux
    print('Signal de demande de soins médicaux envoyé');
  }

  void _sendDangerSignal() {
    // Logique pour envoyer le signal de danger
    print('Signal de danger envoyé');
  }
}

class NavigationUtils {
  Future<void> handleAlertButtonPressed(BuildContext context) async {
    try {
      Position currentLocation = await _getCurrentLocation();
      double latitude = currentLocation.latitude;
      double longitude = currentLocation.longitude;

      String googleMapsLink =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapWebView(url: googleMapsLink),
        ),
      );
    } catch (e) {
      print('Erreur lors de l\'obtention/envoi de la localisation : $e');
    }
  }

  Future<Position> _getCurrentLocation() async {
    print('Obtention de la localisation actuelle');
    return await Geolocator.getCurrentPosition();
  }
}
