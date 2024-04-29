import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapsContainer extends StatelessWidget {
  final String storeName;

  MapsContainer({required this.storeName});

  void _launchMaps() async {
    final encodedQuery = Uri.encodeFull(storeName);
    // Format URL untuk melakukan pencarian di Google Maps berdasarkan nama toko
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$encodedQuery';

    if (await launch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchMaps,
      child: Container(
        padding: EdgeInsets.all(12.0),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            storeName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Contoh Container ke Google Maps'),
      ),
      body: Center(
        child: MapsContainer(
          storeName: 'Toko Contoh', // Ganti dengan nama toko yang ingin Anda cari
        ),
      ),
    ),
  ));
}
