import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/categoria.dart';

class CategoriaProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Categoria> categorias = [];

  CategoriaProvider() {
    obtenerCategorias();
  }

  void obtenerCategorias() {
    db.collection('categorias').snapshots().listen((snapshot) {
      categorias = snapshot.docs.map((doc) {
        final data = doc.data();

        return Categoria(
          id: doc.id,
          nombre: data['nombre'] ?? '',
          descripcion: data['descripcion'] ?? '',
        );
      }).toList();

      notifyListeners();
    });
  }

  Future<void> agregarCategoria({
    required String nombre,
    required String descripcion,
  }) async {
    await db.collection('categorias').add({
      'nombre': nombre,
      'descripcion': descripcion,
    });
  }

  Future<void> editarCategoria({
    required String docId,
    required String nombre,
    required String descripcion,
  }) async {
    await db.collection('categorias').doc(docId).update({
      'nombre': nombre,
      'descripcion': descripcion,
    });
  }

  Future<void> eliminarCategoria(String docId) async {
    await db.collection('categorias').doc(docId).delete();
  }
}