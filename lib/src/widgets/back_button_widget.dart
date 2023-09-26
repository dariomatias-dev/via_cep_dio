import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    required this.action,
  });

  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sair',
      child: IconButton(
        onPressed: () => action(),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
