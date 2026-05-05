import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/proveedor.dart';

class ProveedorProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Proveedor> proveedores = [];

  ProveedorProvider() {
    obtenerProveedores();
  }

  void obtenerProveedores() {
    db.collection('proveedores').snapshots().listen((snapshot) {
      proveedores = snapshot.docs.map((doc) {
        final data = doc.data();

        return Proveedor(
          id: doc.id,
          nombre: data['nombre'] ?? '',
          correo: data['correo'] ?? '',
          telefono: data['telefono'] ?? '',
          direccion: data['direccion'] ?? '',
          estado: data['estado'] ?? 'Activo',
        );
      }).toList();

      notifyListeners();
    });
  }

  Future<void> agregarProveedor({
    required String nombre,
    required String correo,
    required String telefono,
    required String direccion,
    required String estado,
  }) async {
    await db.collection('proveedores').add({
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'direccion': direccion,
      'estado': estado,
    });
  }

  Future<void> editarProveedor({
    required String docId,
    required String nombre,
    required String correo,
    required String telefono,
    required String direccion,
    required String estado,
  }) async {
    await db.collection('proveedores').doc(docId).update({
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'direccion': direccion,
      'estado': estado,
    });
  }

  Future<void> eliminarProveedor(String docId) async {
    await db.collection('proveedores').doc(docId).delete();
  }
}