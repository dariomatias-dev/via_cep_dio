import 'package:via_cep_dio/src/models/via_cep_card_model.dart';

class ViaCepCardsDataModel {
  ViaCepCardsDataModel({
    required this.results,
    required this.count,
  });

  final List<ViaCepCardModel> results;
  final int count;
}
