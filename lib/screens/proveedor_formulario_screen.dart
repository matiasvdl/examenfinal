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

class _ProveedorFormularioScreenState extends State<ProveedorFormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _correoController = TextEditingController();

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
      _apellidoController.text = proveedor!.apellido;
      _correoController.text = proveedor!.correo;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
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
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese correo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final messenger = ScaffoldMessenger.of(context);

                  if (isEdit) {
                    await proveedorProvider.editarProveedor(
                      id: proveedor!.id,
                      nombre: _nombreController.text,
                      apellido: _apellidoController.text,
                      correo: _correoController.text,
                      estado: proveedor!.estado,
                    );
                  } else {
                    await proveedorProvider.agregarProveedor(
                      nombre: _nombreController.text,
                      apellido: _apellidoController.text,
                      correo: _correoController.text,
                      estado: 'Activo',
                    );
                  }

                  if (context.mounted) {
                    Navigator.pop(context);

                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Proveedor guardado'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(isEdit ? 'Guardar cambios' : 'Agregar proveedor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}