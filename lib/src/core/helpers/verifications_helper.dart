import 'package:flutter/material.dart';

import 'package:cep_dio/src/widgets/custom_message_widget.dart';

Widget? verificationsHelper(
  ConnectionState connectionState,
  bool hasError,
) {
  if (connectionState == ConnectionState.waiting) {
    return SizedBox(
      height: 140.0,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.yellow.shade600,
        ),
      ),
    );
  } else if (hasError) {
    return const CustomMessageWidget(
      content: 'Ocorreu um problema ao carregar os dados',
    );
  }

  return null;
}
