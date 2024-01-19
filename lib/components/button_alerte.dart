import 'package:flutter/material.dart';

class BouttonAlerte extends StatelessWidget {
  final Function()? onAlertButtonPressed;
  final String? alertTitle;
  final String? alertContent;

  const BouttonAlerte({
    Key? key,
    required this.onAlertButtonPressed,
    this.alertTitle,
    this.alertContent,
  }) : super(key: key);

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertTitle ?? 'Alerte Entreprise'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alertContent ?? 'Contenu de l\'alerte spécifique à votre entreprise.'),
                // Vous pouvez ajouter plus de widgets pour personnaliser le contenu.
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Fermer la boîte de dialogue
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,  // Ajustez cette valeur selon vos besoins
      height: 150.0, // Ajustez cette valeur selon vos besoins
      child: FloatingActionButton(
        onPressed: () {
          _showAlertDialog(context);
        },
        child: Icon(
          Icons.notifications,
          size: 70.0,
          ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0),
        ),
      ),
    );
  }
}