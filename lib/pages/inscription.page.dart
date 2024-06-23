import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InscriptionPage extends StatelessWidget{
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_pwd = new TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Page Inscription')),
      body: Column(
        children: [
          Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: txt_login,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: "Identifiant",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1)
              )
            ),
          ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_pwd,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1)
                  )
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    minimumSize: Size.fromHeight(50),
    ),
    onPressed: () {
    _onInscrire(context);

    },
    child: Text('Inscription', style: TextStyle(fontSize: 22), )
    ),
    ),
          TextButton(
              child: Text("J'ai déjà un compte",
                style: TextStyle(fontSize: 22),),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/authentification');
              }
          )
        ]
      ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if (!txt_login.text.isEmpty && !txt_pwd.text.isEmpty) {
      prefs.setString("login", txt_login.text);
      prefs.setString("password", txt_pwd.text);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    }
    else{
      const snackBar = SnackBar(content: Text('Id ou mot de passe vides'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}


