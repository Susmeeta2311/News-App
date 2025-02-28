import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CategoryButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: ElevatedButton(
        onPressed: onPressed, // Call the function when pressed
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          foregroundColor: Colors.black,
          side: BorderSide(
            color: Colors.grey, // Border color
            width: 0.5, // Border width
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
