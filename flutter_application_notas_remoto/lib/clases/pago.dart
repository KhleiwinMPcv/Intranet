class Pago {
  final String ciclo;
  final String fecha;
  final double monto;

  Pago({required this.ciclo, required this.fecha, required this.monto});

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      ciclo: json['cic'],
      fecha: json['fec'],
      monto: double.parse(json['mon']),
    );
  }

  double pagoTotal(List<Pago> pagos) {
    double total = 0;
    for (var pago in pagos) {
      total += pago.monto;
    }
    return total;
  }
}
