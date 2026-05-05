import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/producto_response.dart';

class ProductoProvider extends ChangeNotifier {
  final String _baseUrl = "143.198.118.203:8100";
  final String _user = "test";
  final String _pass = "test2023";

  List<Producto> listadoProductos = [];
  bool isLoading = true;

  ProductoProvider() {
    Future.microtask(() => obtenerProductos());
  }

  String get _basicAuth =>
      'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

  Future<void> obtenerProductos() async {
    isLoading = true;
    notifyListeners();

    var url = Uri.http(_baseUrl, 'ejemplos/product_list_rest/');

    final response = await http.get(
      url,
      headers: {'authorization': _basicAuth},
    );

    final productoResponse = productoResponseFromJson(response.body);

    listadoProductos = productoResponse.listado;

    isLoading = false;
    notifyListeners();
  }

  Future<void> agregarProducto({
    required String nombre,
    required int precio,
    required String imagen,
  }) async {
    var url = Uri.http(_baseUrl, 'ejemplos/product_add_rest/');

    final body = jsonEncode({
      "product_name": nombre,
      "product_price": precio,
      "product_image": imagen,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerProductos();
  }

  Future<void> editarProducto({
    required int id,
    required String nombre,
    required int precio,
    required String imagen,
    required String estado,
  }) async {
    var url = Uri.http(_baseUrl, 'ejemplos/product_edit_rest/');

    final body = jsonEncode({
      "product_id": id,
      "product_name": nombre,
      "product_price": precio,
      "product_image": imagen,
      "product_state": estado,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerProductos();
  }

  Future<void> eliminarProducto(int id) async {
    var url = Uri.http(_baseUrl, 'ejemplos/product_del_rest/');

    final body = jsonEncode({
      "product_id": id,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerProductos();
  }
}