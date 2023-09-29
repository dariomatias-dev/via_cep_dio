class ViaCepCardModel {
  ViaCepCardModel({
    required this.id,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.cep,
  });

  final String id;
  final String bairro;
  final String localidade;
  final String uf;
  final String cep;

  factory ViaCepCardModel.fromMap(Map<String, dynamic> map) {
    return ViaCepCardModel(
      id: map['objectId'],
      bairro: map['bairro'],
      localidade: map['localidade'],
      uf: map['uf'],
      cep: map['cep'],
    );
  }
}
