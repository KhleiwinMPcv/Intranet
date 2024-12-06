class Nota {
  final String codc;
  final String nomc;
  final int ep;
  final int ef;

  Nota({
    required this.codc,
    required this.nomc,
    required this.ep,
    required this.ef,
  });

  factory Nota.fromJson(Map<String, dynamic> json) {
    return Nota(
      codc: json['codc'],
      nomc: json['nomc'],
      ep: int.parse(json['ep'].toString()),
      ef: int.parse(json['ef'].toString()),
    );
  }

  double promedio() {
    return (ep + ef * 2) / 3;
  }
}
