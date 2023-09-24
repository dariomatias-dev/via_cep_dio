import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_header_widget/home_screen_header_widget.dart';
import 'package:via_cep_dio/src/screens/home_screen/components/home_screen_body_content_widget/home_screen_body_content_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeScreenHeaderWidget(),
              HomeScreenBodyContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
