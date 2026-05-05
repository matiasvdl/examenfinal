import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/proveedor.dart';
import '../providers/proveedor_provider.dart';
import '../widgets/appbar.dart';

class ProveedorFormularioScreen extends StatefulWidget {
  const ProveedorFormularioScreen({super.key});

  @override
  State<ProveedorFormularioScreen> createState() =>
      _ProveedorFormularioScreenState();
}

class _ProveedorFormularioScreenState
    extends State<ProveedorFormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();

  Proveedor? proveedor;
  bool isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Proveedor && !isEdit) {
      proveedor = args;
      isEdit = true;

      _nombreController.text = proveedor!.nombre;
      _correoController.text = proveedor!.correo;
      _telefonoController.text = proveedor!.telefono;
      _direccionController.text = proveedor!.direccion;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final proveedorProvider =
        Provider.of<ProveedorProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(
        title: isEdit ? 'Editar proveedor' : 'Agregar proveedor',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese correo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  final nuevoProveedor = Proveedor(
                    id: isEdit
                        ? proveedor!.id
                        : DateTime.now().millisecondsSinceEpoch,
                    nombre: _nombreController.text,
                    correo: _correoController.text,
                    telefono: _telefonoController.text,
                    direccion: _direccionController.text,
                    estado: 'Activo',
                  );

                  if (isEdit) {
                    proveedorProvider.editarProveedor(nuevoProveedor);
                  } else {
                    proveedorProvider.agregarProveedor(nuevoProveedor);
                  }

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Proveedor guardado'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  isEdit ? 'Guardar cambios' : 'Agregar proveedor',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}