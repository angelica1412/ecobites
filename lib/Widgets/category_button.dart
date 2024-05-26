import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final String selectedCategory;
  final Function onPressed;

  const CategoryButton({
    Key? key,
    required this.category,
    required this.selectedCategory,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed(category);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (selectedCategory == category) {
            return const Color(0xFF92E3A9);
          }
          return const Color.fromARGB(255, 173, 169, 169);
        }),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>((Set<MaterialState> states) {
          if (selectedCategory == category) {
            return TextStyle(fontWeight: FontWeight.bold);
          }
          return TextStyle(fontWeight: FontWeight.normal);
        }),
      ),
      child: Text(category),
    );
  }
}
