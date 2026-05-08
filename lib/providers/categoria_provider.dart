import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/categoria.dart';

class CategoriaProvider extends ChangeNotifier {
  final String _baseUrl = "143.198.118.203:8100";
  final String _user = "test";
  final String _pass = "test2023";

  List<Categoria> categorias = [];
  bool isLoading = true;

  CategoriaProvider() {
    Future.microtask(() => obtenerCategorias());
  }

  String get _basicAuth =>
      'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

  Future<void> obtenerCategorias() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'ejemplos/category_list_rest/');

    final response = await http.get(
      url,
      headers: {'authorization': _basicAuth},
    );

    final Map<String, dynamic> data = json.decode(response.body);

    final lista = data["Listado Categorias"] ?? [];

    categorias = List<Categoria>.from(
      lista.map((x) => Categoria.fromJson(x)),
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> agregarCategoria({
    required String nombre,
  }) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_add_rest/');

    final body = jsonEncode({
      "category_name": nombre,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerCategorias();
  }

  Future<void> editarCategoria({
    required int id,
    required String nombre,
    required String estado,
  }) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_edit_rest/');

    final body = jsonEncode({
      "category_id": id,
      "category_name": nombre,
      "category_state": estado,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerCategorias();
  }

  Future<void> eliminarCategoria(int id) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_del_rest/');

    final body = jsonEncode({
      "category_id": id,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerCategorias();
  }
}