import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF9A9A9A), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          const Icon(Icons.search, color: Color(0xFF9A9A9A)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 12, color: Color(0xff434343)),
              decoration: const InputDecoration(
                
                border: InputBorder.none,
                
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
