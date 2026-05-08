class Proveedor {
  int id;
  String nombre;
  String apellido;
  String correo;
  String estado;

  Proveedor({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.estado,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        id: json["providerid"],
        nombre: json["provider_name"],
        apellido: json["provider_last_name"],
        correo: json["provider_mail"],
        estado: json["provider_state"],
      );
}