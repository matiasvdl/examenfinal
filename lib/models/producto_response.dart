import 'dart:convert';

ProductoResponse productoResponseFromJson(String str) =>
    ProductoResponse.fromJson(json.decode(str));

class ProductoResponse {
  List<Producto> listado;

  ProductoResponse({
    required this.listado,
  });

  factory ProductoResponse.fromJson(Map<String, dynamic> json) =>
      ProductoResponse(
        listado: List<Producto>.from(
          json["Listado"].map((x) => Producto.fromJson(x)),
        ),
      );
}

class Producto {
  int id;
  String nombre;
  int precio;
  String imagen;
  String estado;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.imagen,
    required this.estado,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["product_id"],
        nombre: json["product_name"],
        precio: json["product_price"],
        imagen: json["product_image"],
        estado: json["product_state"],
      );
}