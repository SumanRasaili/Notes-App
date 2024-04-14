import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  const TitleRow({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: onPressed,
          child: const Text("View All",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        )
      ],
    );
  }
}
