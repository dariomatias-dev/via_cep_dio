import 'package:dio/dio.dart';

import 'package:via_cep_dio/src/core/restClient/rest_client.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

class ViaCepService {
  final dio = dioConfigured();

  final String cardFieldKeys = 'keys=localidade,uf,cep';

  Future<ViaCepCardModel?> getViaCepCardData(cep) async {
    final queries = '?where={"cep": "$cep"}&$cardFieldKeys';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    if (results.isNotEmpty) {
      return ViaCepCardModel.fromMap(results[0]);
    }

    return null;
  }

  Future<List<ViaCepCardModel>> getViaCepCardDatas() async {
    final Response response = await dio.get('?$cardFieldKeys');
    final results = response.data['results'];
    final viaCeps = (results as List<dynamic>).map((viaCepJson) {
      return ViaCepCardModel.fromMap(viaCepJson);
    }).toList();

    return viaCeps;
  }
}
