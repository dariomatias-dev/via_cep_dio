import 'package:flutter/material.dart';

import 'package:via_cep_dio/src/notifiers/via_cep_service_notifier.dart';

import 'package:via_cep_dio/src/providers/main_screen_inherited_widget.dart';
import 'package:via_cep_dio/src/screens/cep_list_view_screen/components/cep_data_request_widget.dart';

import 'package:via_cep_dio/src/screens/cep_list_view_screen/components/cep_search_result_widget.dart';

import 'package:via_cep_dio/src/services/via_cep_service.dart';

class CEPListViewScreen extends StatefulWidget {
  const CEPListViewScreen({super.key});

  @override
  State<CEPListViewScreen> createState() => _CEPListViewScreenState();
}

class _CEPListViewScreenState extends State<CEPListViewScreen> {
  final ViaCepService viaCepService = ViaCepService();

  int _skip = 0;
  final int _limit = 8;

  void _updateSkip(int value) {
    setState(() {
      _skip = value;
    });
  }

  @override
  void initState() {
    viaCepServiceNotifier.onViaCepServiceCalled.listen((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    viaCepServiceNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String cepToSearch =
        MainScreenInheritedWidget.of(context)!.cepToSearch;

    return cepToSearch.isNotEmpty
        ? CEPSearchResultWidget(
            cepToSearch: cepToSearch,
          )
        : CEPDataRequestWidget(
            skip: _skip,
            limit: _limit,
            updateSkip: _updateSkip,
          );
  }
}
