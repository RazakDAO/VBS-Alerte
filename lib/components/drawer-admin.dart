import 'package:flutter/material.dart';
import 'package:vbs_alerte/components/my_list.dart';


class MyDrawerAdmin extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  // Correction : Utilisez 'key' au lieu de 'super.key'
  const MyDrawerAdmin({Key? key, required this.onProfileTap, required this.onSignOut})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 2, 45, 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
             const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            ),
          ),
          MyList(
            icon: Icons.dashboard,
            text: 'Tableau de bord',
            onTap: onProfileTap,
          ),
          MyList(
            // Replace Icons.idCard with an appropriate built-in icon or a custom icon.
            icon: Icons.warning, // Example of using a built-in icon.
            text: 'Liste des alertes',
            onTap: () => Navigator.pop(context),
          ),
          MyList(
            icon: Icons.people,
            text: 'Listes des employés',
            onTap: onProfileTap,
          ),
          MyList(
            icon: Icons.notifications,
            text: 'Notification',
            onTap: onProfileTap,
          ),
          MyList(
            icon: Icons.emergency,
            text: 'Services d\'urgence',
            onTap: onProfileTap,
          ),
           MyList(
            icon: Icons.settings,
            text: 'Paramètre',
            onTap: onProfileTap,
          ),
          ],),
          MyList(
            icon: Icons.logout,
            text: 'Deconnexion',
            onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}
