import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapsContainer extends StatelessWidget {
  final String storeName;
  final String storeAddress;

  const MapsContainer(
      {super.key, required this.storeName, required this.storeAddress});

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
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue, // Background color if the image has transparency
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage('assets/mapsContainer.png'),
            fit: BoxFit.cover, // Adjust the image to cover the container
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: null, // Add any child widget if needed
        ),
      ),
    );
  }
}