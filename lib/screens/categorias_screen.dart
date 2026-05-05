import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/categoria_provider.dart';
import '../widgets/appbar.dart';
import '../widgets/categoria_card.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  void _confirmarEliminar(
    BuildContext context,
    CategoriaProvider categoriaProvider,
    int id,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Eliminar esta categoría?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              categoriaProvider.eliminarCategoria(id);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Categoría eliminada')),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriaProvider = Provider.of<CategoriaProvider>(context);
    final categorias = categoriaProvider.categorias;

    return Scaffold(
      appBar: const AppBarWidget(title: 'Categorías'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'categoria_formulario');
        },
        child: const Icon(Icons.add),
      ),
      body: categorias.isEmpty
          ? const Center(child: Text('No hay categorías'))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];

                return CategoriaCard(
                  categoria: categoria,
                  onVer: () {
                    Navigator.pushNamed(
                      context,
                      'categoria_detalle',
                      arguments: categoria,
                    );
                  },
                  onEditar: () {
                    Navigator.pushNamed(
                      context,
                      'categoria_formulario',
                      arguments: categoria,
                    );
                  },
                  onEliminar: () {
                    _confirmarEliminar(
                      context,
                      categoriaProvider,
                      categoria.id,
                    );
                  },
                );
              },
            ),
    );
  }
}