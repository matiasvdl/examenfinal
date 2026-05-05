import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/producto_response.dart';
import '../providers/producto_provider.dart';
import '../widgets/appbar.dart';

class ProductoFormularioScreen extends StatefulWidget {
  const ProductoFormularioScreen({super.key});

  @override
  State<ProductoFormularioScreen> createState() =>
      _ProductoFormularioScreenState();
}

class _ProductoFormularioScreenState extends State<ProductoFormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _imagenController = TextEditingController();

  Producto? producto;
  bool _isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Producto && !_isEdit) {
      producto = args;
      _isEdit = true;

      _nombreController.text = producto!.nombre;
      _precioController.text = producto!.precio.toString();
      _imagenController.text = producto!.imagen;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _imagenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: _isEdit ? 'Editar producto' : 'Agregar producto',
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
                  labelText: 'Nombre del producto',
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
                controller: _precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese precio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imagenController,
                decoration: const InputDecoration(
                  labelText: 'URL imagen',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese URL de imagen';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final messenger = ScaffoldMessenger.of(context);

                  if (_isEdit) {
                    await productoProvider.editarProducto(
                      id: producto!.id,
                      nombre: _nombreController.text,
                      precio: int.parse(_precioController.text),
                      imagen: _imagenController.text,
                      estado: producto!.estado,
                    );
                  } else {
                    await productoProvider.agregarProducto(
                      nombre: _nombreController.text,
                      precio: int.parse(_precioController.text),
                      imagen: _imagenController.text,
                    );
                  }

                  if (context.mounted) {
                    Navigator.pop(context);

                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Producto guardado'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(_isEdit ? 'Guardar cambios' : 'Agregar producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}