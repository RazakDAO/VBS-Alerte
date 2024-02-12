import 'package:flutter/material.dart';
import 'package:vbs_alerte/components/my_list.dart';
import 'package:vbs_alerte/pages/login_page.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  // Utilisez 'key' au lieu de 'super.key'
  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 2, 45, 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),
              MyList(
                icon: Icons.account_circle,
                text: 'Mon Profil',
                onTap: onProfileTap,
              ),
              MyList(
                icon: Icons.credit_card,
                text: 'Ma pièce d\'identité',
                onTap: () => Navigator.pop(context),
              ),
              MyList(
                icon: Icons.medical_information,
                text: 'Informations médicales',
                onTap: onProfileTap,
              ),
              MyList(
                icon: Icons.medical_information,
                text: 'Services d\'urgence',
                onTap: onProfileTap,
              ),
              MyList(
                icon: Icons.settings,
                text: 'Paramètre',
                onTap: onProfileTap,
              ),
            ],
          ),
          MyList(
              icon: Icons.logout,
              text: 'Déconnexion',
              onTap: () {
                // Appelez le rappel onSignOut fourni
                if (onSignOut != null) {
                  onSignOut!();
                }
                // Naviguez vers la page de connexion
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }),
        ],
      ),
    );
  }
}
