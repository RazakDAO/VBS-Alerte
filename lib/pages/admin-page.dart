import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vbs_alerte/components/drawer-admin.dart';
import 'package:vbs_alerte/pages/login_page.dart';
import 'package:vbs_alerte/pages/profil.dart';
import 'package:vbs_alerte/components/usermap_page.dart';
import 'package:vbs_alerte/pages/setting.dart';
import 'package:vbs_alerte/pages/chat.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<AdminPage> {
  int currentTab = 0;
  late Widget currentScreen;

  // Déclarez des variables pour stocker les identifiants
  String? userId;
  String? companyId;

  @override
  void initState() {
    super.initState();
    currentScreen = UserMap();
    // Appel à la fonction pour récupérer les identifiants une fois que l'utilisateur est connecté
    _getUserData();
  }

  // Fonction pour récupérer l'identifiant de l'utilisateur et de la compagnie
  void _getUserData() async {
    try {
      // Récupérez l'utilisateur actuellement connecté
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          userId = user.uid;
        });
        print("Identifiant de l'utilisateur récupéré avec succès.");
      }

      // Récupérez l'identifiant de la compagnie de votre backend
      final token = await user!.getIdToken();
      await getUserAndCompanyInfo(token!);
    } catch (error) {
      if (kDebugMode) {
        print("Erreur lors de la récupération des données utilisateur: $error");
      }
    }
  }

  Future<void> getUserAndCompanyInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://vbs-alert-api.onrender.com/api/user-info'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          companyId = responseData['companyId'];
        });
        print("Identifiant de la compagnie récupéré avec succès.");
      }
    } catch (error) {
      print(
          "Erreur lors de la récupération des informations utilisateur: $error");
    }
  }

  Future<void> sendAlert(BuildContext scaffoldContext) async {
    showDialog(
      context: scaffoldContext,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 222, 225, 225),
          shape: RoundedRectangleBorder(
            // Définit la forme de l'AlertDialog
            borderRadius: BorderRadius.circular(10.0), // Arrondit les coins
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0), // Ajoute du padding autour du contenu
          title: Center(
            child: Text(
              'Voulez-vous envoyer une alerte?',
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromARGB(255, 2, 45, 80)),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      sendAlertToAPI(scaffoldContext);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 2, 45, 80)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('Oui', style: TextStyle(fontSize: 14.0)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 2, 45, 80)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text('Non', style: TextStyle(fontSize: 14.0)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
    print("Boîte de dialogue d'alerte affichée.");
  }

  Future<void> sendAlertToAPI(BuildContext scaffoldContext) async {
    // Afficher la boîte de dialogue de chargement
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                const Color.fromARGB(255, 2, 45, 80)), // Changez la couleur ici
          ),
        );
      },
    );
    print("Boîte de dialogue de chargement affichée.");
    try {
      // Récupérer la localisation actuelle
      Position position = await getCurrentLocation();
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      print("Localisation actuelle récupérée avec succès.");

      // Construire les données de l'alerte avec la localisation récupérée
      var alertData = {
        "companyId": companyId,
        "employeeId": userId,
        "alertType": "GENERAL",
        "alertStatus": "",
        "message": "Alerte générale signalez votre statut maintenant svp",
        "alertLocation": {
          "longitude": position.longitude,
          "latitude": position.latitude
        }
      };

      // Convertir les données de l'alerte en JSON
      var jsonData = jsonEncode(alertData);

      // Envoyer la requête POST pour envoyer l'alerte
      final response = await http.post(
        Uri.parse('https://vbs-alert-api.onrender.com/api/alerts'),
        body: jsonData,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTcwMjA1MDIzOSwiZXhwIjoxNzMzNTg2MjM5fQ.vlAMLEwlVnkDYZRt5pz9QqaJtWoenAbf76gvrcNBSHk',
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      // Fermer la boîte de dialogue de chargement
      // ignore: use_build_context_synchronously
      Navigator.of(scaffoldContext).pop();
      print("Boîte de dialogue de chargement fermée avec succès.");

      // Afficher le message de retour de l'API
      final responseData = json.decode(response.body);
      // ignore: use_build_context_synchronously
      print(response.body);
      // Si l'envoi de l'alerte est réussi
      if (response.statusCode == 200) {
        // Traitez ici la réponse de l'API si nécessaire
        showSnackBar(scaffoldContext, responseData["message"]);
      }
    } catch (error) {
      // Gérer les erreurs
      // ignore: use_build_context_synchronously
      showSnackBar(
          scaffoldContext, 'Erreur lors de l\'envoi de l\'alerte: $error');
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("Erreur lors de la récupération de la localisation: $e");
      throw e;
    }
  }

  Widget _buildBottomNavBarButton(IconData icon, String label, int tabIndex) {
    return Expanded(
      child: MaterialButton(
        minWidth: 10,
        onPressed: () {
          setState(() {
            switch (tabIndex) {
              case 0:
                currentScreen = UserMap();
                break;
              case 1:
                currentScreen = Chat();
                break;
              case 2:
                currentScreen = Profil();
                break;
              case 3:
                currentScreen = Setting();
                break;
            }
            currentTab = tabIndex;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: currentTab == tabIndex ? Colors.white : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 6,
                color: currentTab == tabIndex ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToProfilePage(BuildContext context) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              'Administrateur',
              style: TextStyle(
                fontSize: 22.0,
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
        drawer: MyDrawerAdmin(
          onProfileTap: () => goToProfilePage(context),
          onSignOut: () {
            print('Déconnexion');
          },
        ),
        body: PageStorage(
          child: currentScreen,
          bucket: PageStorageBucket(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add_alert, color: Colors.white, size: 35),
          onPressed: () {
            // Appel de la fonction pour afficher la boîte de dialogue de confirmation
            sendAlert(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          color: Color.fromARGB(255, 2, 45, 80),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildBottomNavBarButton(Icons.dashboard, 'Menu', 0),
                _buildBottomNavBarButton(Icons.warning, 'Alertes', 1),
                SizedBox(width: 65), // Ajout d'un espace de 65 pixels
                _buildBottomNavBarButton(Icons.people, 'Employés', 2),
                _buildBottomNavBarButton(Icons.settings, 'Paramètre', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(AdminPage());
}
