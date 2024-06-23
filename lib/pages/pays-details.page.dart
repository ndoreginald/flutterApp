import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class PaysDetailsPage extends StatefulWidget {
  final String keyword;

  PaysDetailsPage(this.keyword);

  @override
  State<PaysDetailsPage> createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetailsPage> {
  var countryData;

  @override
  void initState() {
    super.initState();
    fetchCountryData(widget.keyword);
  }

  void fetchCountryData(String keyword) async {
    try {
      final response = await http.get(Uri.parse('https://restcountries.com/v2/name/$keyword'));
      if (response.statusCode == 200) {
        setState(() {
          countryData = json.decode(response.body)[0];
        });
      } else {
        throw Exception('Failed to load country data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching country data: $e');
      // Handle error (e.g., show error message to user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pays Details Page',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue
      ),
      body: countryData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: countryData['flag'].toString().endsWith('.svg')
                  ? SvgPicture.network(
                countryData['flag'],
                width: 250,
              )
                  : Image.network(
                countryData['flag'],
                width: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nom: ${countryData['name']}',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            Text(
              'Capitale: ${countryData['capital']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Continent: ${countryData['region']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Region: ${countryData['subregion']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Population: ${countryData['population']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Superficie: ${countryData['area']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            _buildLanguagesRow(countryData['languages']),
            SizedBox(height: 10),
            Text(
              'Monnaie: ${countryData['currencies'][0]['name']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Code ISO: ${countryData['alpha3Code']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Calling Code: +${countryData['callingCodes']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Fuseau horaire: ${countryData['timezones'][0]}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguagesRow(List<dynamic> languages) {
    String languagesText = '';
    for (int i = 0; i < languages.length; i++) {
      languagesText += '${languages[i]['name']} ';
      if (i < languages.length - 1) {
        languagesText += ', ';
      }
    }
    return Text(
      'Langues: $languagesText',
      style: TextStyle(fontSize: 20),
    );
  }
}
