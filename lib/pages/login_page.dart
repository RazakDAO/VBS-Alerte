import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vbs_alerte/components/button.dart';
import 'package:vbs_alerte/components/text_field.dart';
import 'package:vbs_alerte/pages/alerte_page.dart';
import 'package:vbs_alerte/pages/admin-page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isLoading = false;

  Future<void> loginUser() async {
    if (!isFormValid()) {
      showSnackBar('Veuillez remplir tous les champs');
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://sore-gray-cygnet-wear.cyclic.app/api/login'),
        body: jsonEncode({
          'phone_number': phoneTextController.text,
          'password': passwordTextController.text,
        }),
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTcwMjA1MDIzOSwiZXhwIjoxNzMzNTg2MjM5fQ.vlAMLEwlVnkDYZRt5pz9QqaJtWoenAbf76gvrcNBSHk',
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      final responseData = json.decode(response.body);
      showSnackBar(responseData["message"]);

      if (responseData["message"] == "L'utilisateur s'est connecté avec succès.") {
        final role = responseData["data"]["role"];
        navigateToPage(role);
      }
    } catch (error) {
      showSnackBar('Erreur: $error');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  bool isFormValid() {
    return phoneTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void navigateToPage(String role) {
    if (role == "ADMIN") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AdminPage()),
      );
    } else if (role == "USER") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyAlertScreen()),
      );
    }
  }

  @override
  void dispose() {
    phoneTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 200,
                  ),
                  const SizedBox(height: 15),
                   Text(
                    'Bienvenue sur Vbs Alerte',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: phoneTextController,
                    hinText: 'Numéro de téléphone',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: passwordTextController,
                    hinText: 'Mot de passe',
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  MyButton(
                    onTap: () async {
                      if (isLoading) {
                        // Faire quelque chose en cas de chargement en cours
                      } else {
                        await loginUser();
                      }
                    },
                    text: isLoading ? 'Connexion...' : 'Connexion',
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
