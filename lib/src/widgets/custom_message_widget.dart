import 'package:flutter/material.dart';

class CustomMessageWidget extends StatelessWidget {
  const CustomMessageWidget({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Center(
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
