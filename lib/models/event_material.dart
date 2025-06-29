class EventMaterial {
  final String cod;
  final String nombre;
  final String descripcion;
  final double precio;
  final String codEvento;

  EventMaterial({
    required this.cod,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.codEvento,
  });

  @override
  String toString() {
    return 'EventMaterial(cod: $cod,  nombre: $nombre, descripcion: $descripcion, precio: $precio, codEvento: $codEvento)';
  }
}
