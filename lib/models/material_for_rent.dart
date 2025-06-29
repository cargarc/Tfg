class MaterialForRent {
  final String cod;
  final String descripcion;
  final int cantidad;
  final double precio;
  final String estado;

  MaterialForRent({
    required this.cod,
    required this.descripcion,
    required this.cantidad,
    required this.precio,
    required this.estado,
  });

  @override
  String toString() {
    return 'MaterialForRent(cod: $cod, descripcion: $descripcion, cantidad: $cantidad, precio: $precio,  estado: $estado)';
  }
}
