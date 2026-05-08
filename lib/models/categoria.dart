class Categoria {
  int id;
  String nombre;
  String estado;

  Categoria({
    required this.id,
    required this.nombre,
    required this.estado,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["category_id"],
        nombre: json["category_name"],
        estado: json["category_state"],
      );
}