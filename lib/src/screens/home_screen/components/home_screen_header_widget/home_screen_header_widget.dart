import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_header_widget/cep_search_widget.dart';

class HomeScreenHeaderWidget extends StatelessWidget {
  const HomeScreenHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 26.0,
        horizontal: 24.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Via CEP',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          CEPSearchWidget(),
        ],
      ),
    );
  }
}
