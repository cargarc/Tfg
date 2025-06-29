class OwnMaterial {
  final String cod;
  final String descripcion;
  final double precio;
  final DateTime fechaAmortizacion;
  final String estado;

  OwnMaterial({
    required this.cod,
    required this.descripcion,
    required this.precio,
    required this.fechaAmortizacion,
    required this.estado,
  });

  @override
  String toString() {
    return 'OwnMaterial(cod: $cod, descripcion: $descripcion, precio: $precio, fechaAmortizacion: $fechaAmortizacion, estado: $estado)';
  }
}
