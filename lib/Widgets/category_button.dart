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
            return Colors.greenAccent;
          }
          return Colors.white;
        }),
      ),
      child: Text(
        category,
        textAlign: TextAlign.center,
        ),
    );
  }
}
