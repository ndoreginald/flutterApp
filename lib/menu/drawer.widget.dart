import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter_app/pages/home.page.dart";
import "../config/global.params.dart";


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue]
                )
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profil.jpg"),
                radius: 80,
              ),
            ),
          ),
          ...GlobalParams.menus.map((item) {
            return Column(
              children: [
                ListTile(
                  title: Text(item['title']),
                  leading: item['icon'],
                  trailing: Icon(Icons.arrow_right),
                  onTap: () async {
                    if (item['title'] != "Déconnexion") {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, item['route']);
                    } else {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool("connecte", false);
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/authentification", (route) => false);
                    }
                  },
                ),
                Divider(
                  height: 4,
                  color: Colors.blue,
                ),
              ],
            );
          })
              .toList(),
        ],
      ),
    );
  }
}

