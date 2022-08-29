import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  final String label;

  const TabBarItem({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 8,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          height: 1.22,
        ),
      ),
    );
  }
}
