import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF9A9A9A), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          SizedBox(width: 8),
          Icon(Icons.search, color: Color(0xFF9A9A9A)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
