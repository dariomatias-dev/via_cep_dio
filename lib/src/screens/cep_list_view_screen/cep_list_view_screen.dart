import 'package:flutter/material.dart';

import 'package:cep_dio/src/providers/main_screen_inherited_widget.dart';

import 'package:cep_dio/src/screens/cep_list_view_screen/components/cep_data_request_widget.dart';
import 'package:cep_dio/src/screens/cep_list_view_screen/components/cep_search_result_widget.dart';

class CEPListViewScreen extends StatefulWidget {
  const CEPListViewScreen({super.key});

  @override
  State<CEPListViewScreen> createState() => _CEPListViewScreenState();
}

class _CEPListViewScreenState extends State<CEPListViewScreen> {
  @override
  Widget build(BuildContext context) {
    final String cepToSearch =
        MainScreenInheritedWidget.of(context)!.cepToSearch;

    return cepToSearch.isNotEmpty
        ? CepSearchResultWidget(
            cepToSearch: cepToSearch,
          )
        : const CepDataRequestWidget();
  }
}
