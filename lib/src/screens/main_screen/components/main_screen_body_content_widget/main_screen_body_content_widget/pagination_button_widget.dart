import 'package:flutter/material.dart';

class PaginationButtonWidget extends StatelessWidget {
  const PaginationButtonWidget({
    super.key,
    required this.icon,
    required this.action,
  });

  final IconData icon;
  final void Function()? action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        padding: const EdgeInsets.all(1.0),
        disabledBackgroundColor: Colors.grey.shade300,
        shape: const CircleBorder(),
      ),
      child: Icon(
        icon,
        color: action != null ? Colors.grey.shade400 : Colors.grey.shade100,
      ),
    );
  }
}
