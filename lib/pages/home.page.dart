import 'package:flutter/material.dart';
import 'package:flutter_app/config/global.params.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../menu/drawer.widget.dart';


class HomePage extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text(  "Page d'Accueil", style: TextStyle(color: Colors.white),
           ), backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Wrap(
          children: [
            ...GlobalParams.accueil.map((item) {
              return InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: item['image'],
                ),
                onTap: () {
                  Navigator.pushNamed(context, item['route']);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Future<void> _Deconnexion(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);
    Navigator.of(context).pushNamedAndRemoveUntil('/authentification', (Route<dynamic> route) => false);
  }
}
