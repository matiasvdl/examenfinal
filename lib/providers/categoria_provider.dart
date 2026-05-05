import 'package:flutter/material.dart';

import '../models/categoria.dart';

class CategoriaProvider extends ChangeNotifier {
  final List<Categoria> categorias = [
    Categoria(
      id: 1,
      nombre: 'Tecnología',
      descripcion: 'Productos tecnológicos',
      estado: 'Activo',
    ),
    Categoria(
      id: 2,
      nombre: 'Oficina',
      descripcion: 'Artículos de oficina',
      estado: 'Activo',
    ),
    Categoria(
      id: 3,
      nombre: 'Hogar',
      descripcion: 'Productos para el hogar',
      estado: 'Activo',
    ),
  ];

  void agregarCategoria(Categoria categoria) {
    categorias.add(categoria);
    notifyListeners();
  }

  void editarCategoria(Categoria categoria) {
    final index = categorias.indexWhere((item) => item.id == categoria.id);

    if (index >= 0) {
      categorias[index] = categoria;
      notifyListeners();
    }
  }

  void eliminarCategoria(int id) {
    categorias.removeWhere((categoria) => categoria.id == id);
    notifyListeners();
  }
}