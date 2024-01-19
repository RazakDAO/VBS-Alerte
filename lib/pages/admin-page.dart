import 'package:flutter/material.dart';
import 'package:vbs_alerte/components/drawer-admin.dart';
// import 'package:vbs2/components/local-notifications.dart';
import 'package:vbs_alerte/pages/profile-page.dart';
import 'package:vbs_alerte/pages/profil.dart';
// import 'package:vbs2/pages/dashboard.dart';
import 'package:vbs_alerte/components/usermap_page.dart';
import 'package:vbs_alerte/pages/setting.dart';
import 'package:vbs_alerte/pages/chat.dart';

class AdminPage extends StatefulWidget {
 @override
 _AdminState createState() => _AdminState();
}

class _AdminState extends State<AdminPage> {
void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Choisir le type d\'alerte',
          style: TextStyle(fontSize: 18.0),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAlertButton(context, 'Incendie', Icons.local_fire_department_sharp),
            _buildAlertButton(context, 'Médicale', Icons.local_hospital),
            _buildAlertButton(context, 'Police', Icons.local_police),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        backgroundColor: Colors.white, // Remplacez par la couleur souhaitée
        clipBehavior: Clip.antiAliasWithSaveLayer,
      );
    },
  );
}


Widget _buildAlertButton(BuildContext context, String alertType, IconData iconData) {
  return TextButton(
    onPressed: () {
      // Traitement à effectuer en fonction du type d'alerte choisi
      print('Alerte de type $alertType');
      Navigator.of(context).pop();
    },
    child: Column(
      children: [
        Icon(iconData, size: 24),
        SizedBox(height: 5),
        Text(
          alertType,
          style: TextStyle(fontSize: 12),  // Ajustez cette valeur
        ),
      ],
    ),
  );
}




 int currentTab = 0;
 late Widget currentScreen;

 @override
 void initState() {
  super.initState();
  currentScreen = UserMap();
  
 }

 void goToProfilePage(BuildContext context) {
  Navigator.pop(context);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfilePage()),
  );
 }

 void _showNotification() {
  _showAlertDialog(context);
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
        onPressed: _showNotification,
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
}
