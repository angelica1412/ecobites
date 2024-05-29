import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapsContainer extends StatelessWidget {
  final String storeName;
  final String storeAddress;

  const MapsContainer({super.key, required this.storeName, required this.storeAddress});

  void _launchMaps() async {
    final encodedQueryName = Uri.encodeFull(storeName);
    final encodedQueryAddress = Uri.encodeFull(storeAddress);
    // Format URL untuk melakukan pencarian di Google Maps berdasarkan nama toko
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$encodedQueryName $encodedQueryAddress';

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
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            storeName,
            style: const TextStyle(
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
