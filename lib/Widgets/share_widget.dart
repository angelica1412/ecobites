import 'package:flutter/material.dart';

class ShareWidget {
  static void showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareItem(
                    'WhatsApp',
                    'assets/whatsapp.png', // Gambar logo WhatsApp
                    Colors.green.withOpacity(0.3),
                        () {
                      // Action to share on WhatsApp
                      print('Sharing on WhatsApp');
                    },
                  ),
                  _buildShareItem(
                    'Instagram',
                    'assets/instagram.png', // Gambar logo Instagram
                    Colors.pinkAccent.withOpacity(0.3),
                        () {
                      // Action to share on Instagram
                      print('Sharing on Instagram');
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildShareItem(String text, String imagePath, Color backgroundColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    imagePath, // Path gambar
                    height: 30, // Tinggi gambar
                    width: 30, // Lebar gambar
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}