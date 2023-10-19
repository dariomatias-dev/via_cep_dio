import 'package:cep_dio/src/models/basic_cep_model.dart';

class CepCollectionModel {
  CepCollectionModel({
    required this.results,
    required this.count,
  });

  final List<BasicCepModel> results;
  final int count;

  factory CepCollectionModel.empty() {
    return CepCollectionModel(
      results: [],
      count: 0,
    );
  }
}
