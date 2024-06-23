import 'package:flutter/material.dart';
import 'package:flutter_app/pages/authentification.page.dart';
import 'package:flutter_app/pages/home.page.dart';
import 'package:flutter_app/pages/inscription.page.dart';
import 'package:flutter_app/pages/meteo.page.dart';
import 'package:flutter_app/pages/pays.page.dart';
import 'package:flutter_app/pages/gallerie.page.dart'; // Ajoutez cette importation
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = {
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/meteo': (context) => MeteoPage(),
    '/pays': (context) => PaysPage(), // Ajoutez cette ligne
    '/gallerie': (context) => GalleriePage(), // Ajoutez cette ligne
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Affiche un indicateur de chargement pendant l'attente
          } else if (snapshot.hasData) {
            bool conn = snapshot.data?.getBool('connecte') ?? false;
            if (conn) return HomePage();
          }
          return AuthentificationPage();
        },
      ),
    );
  }
}
