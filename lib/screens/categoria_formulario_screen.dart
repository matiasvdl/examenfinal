import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/categoria.dart';
import '../providers/categoria_provider.dart';
import '../widgets/appbar.dart';

class CategoriaFormularioScreen extends StatefulWidget {
  const CategoriaFormularioScreen({super.key});

  @override
  State<CategoriaFormularioScreen> createState() =>
      _CategoriaFormularioScreenState();
}

class _CategoriaFormularioScreenState extends State<CategoriaFormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();

  Categoria? categoria;
  bool isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Categoria && !isEdit) {
      categoria = args;
      isEdit = true;

      _nombreController.text = categoria!.nombre;
      _descripcionController.text = categoria!.descripcion;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriaProvider =
        Provider.of<CategoriaProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(
        title: isEdit ? 'Editar categoría' : 'Agregar categoría',
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
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese descripción';
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
                    await categoriaProvider.editarCategoria(
                      docId: categoria!.id,
                      nombre: _nombreController.text,
                      descripcion: _descripcionController.text,
                    );
                  } else {
                    await categoriaProvider.agregarCategoria(
                      nombre: _nombreController.text,
                      descripcion: _descripcionController.text,
                    );
                  }

                  if (context.mounted) {
                    Navigator.pop(context);

                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Categoría guardada'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(isEdit ? 'Guardar cambios' : 'Agregar categoría'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}