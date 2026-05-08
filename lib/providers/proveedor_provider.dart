import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/proveedor.dart';

class ProveedorProvider extends ChangeNotifier {
  final String _baseUrl = "143.198.118.203:8100";
  final String _user = "test";
  final String _pass = "test2023";

  List<Proveedor> proveedores = [];
  bool isLoading = true;

  ProveedorProvider() {
    Future.microtask(() => obtenerProveedores());
  }

  String get _basicAuth =>
      'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

  Future<void> obtenerProveedores() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'ejemplos/provider_list_rest/');

    final response = await http.get(
      url,
      headers: {'authorization': _basicAuth},
    );

    final Map<String, dynamic> data = json.decode(response.body);

    final lista = data["Proveedores Listado"] ?? [];

    proveedores = List<Proveedor>.from(
      lista.map((x) => Proveedor.fromJson(x)),
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> agregarProveedor({
    required String nombre,
    required String apellido,
    required String correo,
    required String estado,
  }) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_add_rest/');

    final body = jsonEncode({
      "provider_name": nombre,
      "provider_last_name": apellido,
      "provider_mail": correo,
      "provider_state": estado,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerProveedores();
  }

  Future<void> editarProveedor({
    required int id,
    required String nombre,
    required String apellido,
    required String correo,
    required String estado,
  }) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_edit_rest/');

    final body = jsonEncode({
      "provider_id": id,
      "provider_name": nombre,
      "provider_last_name": apellido,
      "provider_mail": correo,
      "provider_state": estado,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerProveedores();
  }

  Future<void> eliminarProveedor(int id) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_del_rest/');

    final body = jsonEncode({
      "provider_id": id,
    });

    await http.post(
      url,
      headers: {
        'authorization': _basicAuth,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    await obtenerProveedores();
  }
}