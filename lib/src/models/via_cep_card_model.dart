class ViaCepCardModel {
  ViaCepCardModel({
    required this.localidade,
    required this.uf,
    required this.cep,
  });

  final String localidade;
  final String uf;
  final String cep;

  factory ViaCepCardModel.fromMap(Map<String, dynamic> map) {
    return ViaCepCardModel(
      localidade: map['localidade'],
      uf: map['uf'],
      cep: map['cep'],
    );
  }
}
