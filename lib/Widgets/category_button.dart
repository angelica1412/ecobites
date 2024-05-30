import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final String selectedCategory;
  final Function onPressed;

  const CategoryButton({super.key,
    required this.category,
    required this.selectedCategory,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed(category);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (selectedCategory == category) {
            return const Color(0xFF92E3A9); // Warna background ketika kategori terpilih
          }
          return Color.fromARGB(255, 182, 174, 174); // Warna background default
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (selectedCategory == category) {
            return Colors.white; // Warna teks ketika kategori terpilih
          }
          return Colors.black; // Warna teks default
        }),
      ),
      child: Text(
        category,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: selectedCategory == category ? 16 : 14, // Ukuran teks berubah
          fontWeight: selectedCategory == category ? FontWeight.bold : FontWeight.normal, // Ketebalan teks berubah
        ),
      ),
    );
  }
}