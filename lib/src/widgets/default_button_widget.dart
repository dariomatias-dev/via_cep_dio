import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    super.key,
    required this.text,
    required this.action,
  });

  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 60.0,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: ElevatedButton(
        onPressed: () => action(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
