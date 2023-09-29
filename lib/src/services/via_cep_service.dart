import 'package:dio/dio.dart';

import 'package:via_cep_dio/src/core/rest_client/rest_client.dart';

import 'package:via_cep_dio/src/models/via_cep_card_model.dart';
import 'package:via_cep_dio/src/models/via_cep_cards_data_model.dart';
import 'package:via_cep_dio/src/models/via_cep_model.dart';

import 'package:via_cep_dio/src/notifiers/via_cep_service_notifier.dart';

class ViaCepService {
  final dio = dioConfigured();

  final String cardFieldKeys = 'keys=localidade,uf,cep';

  Future<void> createViaCep(ViaCepModel viaCep) async {
    await dio.post(
      '',
      data: viaCep.toMap(),
    );
    viaCepServiceNotifier.notify();
  }

  Future<ViaCepCardModel?> getViaCepCardData(cep) async {
    final String queries = '?where={"cep": "$cep"}&$cardFieldKeys';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    if (results.isNotEmpty) {
      return ViaCepCardModel.fromMap(results[0]);
    }

    return null;
  }

  Future<ViaCepCardsDataModel> getViaCepCardDatas() async {
    //final String queries = 'skip=$skip&limit=8&count=1';
    final Response response = await dio.get('?$cardFieldKeys&count=1');
    final Map<String, dynamic> data = response.data;
    final List<dynamic> results = data['results'];
    final int count = data['count'];
    final List<ViaCepCardModel> viaCepCardDatas = results.map((
      viaCepCardsJson,
    ) {
      return ViaCepCardModel.fromMap(
        viaCepCardsJson,
      );
    }).toList();

    return ViaCepCardsDataModel(
      results: viaCepCardDatas,
      count: count,
    );
  }

  Future<ViaCepModel> getViaCep(String viaCepId) async {
    final String queries = '?where={"objectId": "$viaCepId"}';
    final Response response = await dio.get(queries);
    final List<dynamic> results = response.data['results'];

    return ViaCepModel.fromMap(results[0]);
  }

  Future<void> updateViaCep(String viaCepId, ViaCepModel viaCep) async {
    await dio.put(
      viaCepId,
      data: viaCep.toMap(),
    );
    viaCepServiceNotifier.notify();
  }

  Future<void> deleteViaCep(String viaCepId) async {
    await dio.delete(viaCepId);
    viaCepServiceNotifier.notify();
  }
}
