 
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vbs_alerte/components/button.dart';
import 'package:vbs_alerte/components/text_field.dart';
import 'package:vbs_alerte/models/apiResponseModel.dart';
import 'package:vbs_alerte/pages/alerte_page.dart';
import 'package:vbs_alerte/pages/admin-page.dart';
import 'package:vbs_alerte/services/api_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> loginUser() async {
    if (isFormValid()) {
      setState(() {
        isLoading = true;
      });
      ApiResponseModel response =
          await loginAPI(phoneTextController.text, passwordTextController.text);

      if (response.message == "L'utilisateur s'est connecté avec succès.") {
        Fluttertoast.showToast(
            msg: "Connexion reussie",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        navigateToPage(response.data['role']);
      } else {
        Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Veuillez remplir tous les champs du formulaire.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  bool isFormValid() {
    return phoneTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty;
  }

  void navigateToPage(String role) {
    if (role == "ADMIN") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AdminPage()),
      );
    } else if (role == "USER") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyAlertScreen()),
      );
    }
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
                  if (isLoading)
                    const SpinKitFadingCircle(
                      color: Color.fromARGB(255, 2, 45, 80),
                      size: 50.0,
                    ),
                  if (!isLoading)
                    MyButton(
                        onTap: () async {
                          await loginUser();
                        },
                        text: "Se connecter"),
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
