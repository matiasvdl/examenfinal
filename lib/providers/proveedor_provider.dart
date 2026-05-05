import 'package:flutter/material.dart';
import '../models/proveedor.dart';

class ProveedorProvider extends ChangeNotifier {
  final List<Proveedor> proveedores = [
    Proveedor(
      id: 1,
      nombre: 'Empresas Vidal',
      correo: 'contacto@evidal.cl',
      telefono: '+56 9 1234 5678',
      direccion: 'Rancagua, Chile',
      estado: 'Activo',
    ),
    Proveedor(
      id: 2,
      nombre: 'Distribuidora Perez',
      correo: 'ventas@dperez.cl',
      telefono: '+56 9 1234 5678',
      direccion: 'Santiago, Chile',
      estado: 'Activo',
    ),
  ];

  void agregarProveedor(Proveedor proveedor) {
    proveedores.add(proveedor);
    notifyListeners();
  }

  void editarProveedor(Proveedor proveedor) {
    final index = proveedores.indexWhere((item) => item.id == proveedor.id);

    if (index >= 0) {
      proveedores[index] = proveedor;
      notifyListeners();
    }
  }

  void eliminarProveedor(int id) {
    proveedores.removeWhere((proveedor) => proveedor.id == id);
    notifyListeners();
  }
}