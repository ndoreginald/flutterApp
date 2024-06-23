import 'package:flutter/material.dart';

class GlobalParams {
  static List<Map<String, dynamic>> menus = [
    {
      "title": "Accueil",
      "icon": Icon(
        Icons.home,
        color: Colors.blue,
      ),
      "route": "/home"
    },
    {
      "title": "Météo",
      "icon": Icon(
        Icons.sunny_snowing,
        color: Colors.blue,
      ),
      "route": "/meteo"
    },
    {
      "title": "Gallerie",
      "icon": Icon(
        Icons.photo,
        color: Colors.blue,
      ),
      "route": "/gallerie"
    },
    {
      "title": "Pays",
      "icon": Icon(
        Icons.location_city,
        color: Colors.blue,
      ),
      "route": "/pays"
    },
    {
      "title": "Déconnexion",
      "icon": Icon(
        Icons.logout,
        color: Colors.blue,
      ),
      "route": "/authentification"
    },
  ];

  static List<Map<String, dynamic>> accueil = [
    {
      "titre": "Météo",
      "image": AssetImage("assets/images/meteo.png"),
      "route": "/meteo",
    },
    {
      "titre": "Gallerie",
      "image": AssetImage("assets/images/gallerie.png"),
      "route": "/gallerie",
    },
    {
      "titre": "Pays",
      "image": AssetImage("assets/images/pays.png"),
      "route": "/pays",
    },
    {
      "titre": "Deconnexion",
      "image": AssetImage("assets/images/deconnexion.png"),
      "route": "/authentification",
    },
  ];
}