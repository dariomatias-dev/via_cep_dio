class ViaCepCardModel {
  ViaCepCardModel({
    required this.id,
    required this.localidade,
    required this.uf,
    required this.cep,
  });

  final String id;
  final String localidade;
  final String uf;
  final String cep;

  factory ViaCepCardModel.fromMap(Map<String, dynamic> map) {
    return ViaCepCardModel(
      id: map['objectId'],
      localidade: map['localidade'],
      uf: map['uf'],
      cep: map['cep'],
    );
  }
}
