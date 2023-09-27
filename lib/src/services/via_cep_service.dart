import 'package:dio/dio.dart';

import 'package:via_cep_dio/src/core/rest_client/rest_client.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';
import 'package:via_cep_dio/src/models/via_cep_model.dart';

class ViaCepService {
  final dio = dioConfigured();

  final String cardFieldKeys = 'keys=localidade,uf,cep';

  Future<ViaCepCardModel?> getViaCepCardData(cep) async {
    final String queries = '?where={"cep": "$cep"}&$cardFieldKeys';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    if (results.isNotEmpty) {
      return ViaCepCardModel.fromMap(results[0]);
    }

    return null;
  }

  Future<List<ViaCepCardModel>> getViaCepCardDatas() async {
    final Response response = await dio.get('?$cardFieldKeys');
    final List<dynamic> results = response.data['results'];
    final List<ViaCepCardModel> viaCepCardDatas = results.map((
      viaCepCardDataJson,
    ) {
      return ViaCepCardModel.fromMap(
        viaCepCardDataJson,
      );
    }).toList();

    return viaCepCardDatas;
  }

  Future<ViaCepModel> getViaCep(String cep) async {
    final String queries = '?where={"cep": "$cep"}';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    return ViaCepModel.fromMap(results[0]);
  }

  Future<void> deleteViaCep(String viaCepId) async {
    await dio.delete(viaCepId);
  }
}
