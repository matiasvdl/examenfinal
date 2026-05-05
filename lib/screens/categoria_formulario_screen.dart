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

class _CategoriaFormularioScreenState
    extends State<CategoriaFormularioScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese nombre' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descripcionController,
                decoration:
                    const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  final nueva = Categoria(
                    id: isEdit
                        ? categoria!.id
                        : DateTime.now().millisecondsSinceEpoch,
                    nombre: _nombreController.text,
                    descripcion: _descripcionController.text,
                    estado: 'Activo',
                  );

                  if (isEdit) {
                    categoriaProvider.editarCategoria(nueva);
                  } else {
                    categoriaProvider.agregarCategoria(nueva);
                  }

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Categoría guardada')),
                  );
                },
                child: Text(isEdit ? 'Guardar' : 'Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}