import 'package:flutter/material.dart';
import '../screens/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'registro': (BuildContext context) => const RegistroScreen(),
    'menu': (BuildContext context) => const MenuScreen(),
    'productos': (BuildContext context) => const HomeScreen(),
    'producto_detalle': (BuildContext context) => const ProductoDetalleScreen(),
    'producto_formulario': (BuildContext context) =>
        const ProductoFormularioScreen(),
    'proveedores': (BuildContext context) => const ProveedoresScreen(),
    'proveedor_detalle': (BuildContext context) =>
        const ProveedorDetalleScreen(),
    'proveedor_formulario': (BuildContext context) =>
        const ProveedorFormularioScreen(),
    'categorias': (BuildContext context) => const CategoriasScreen(),
    'categoria_detalle': (BuildContext context) =>
        const CategoriaDetalleScreen(),
    'categoria_formulario': (BuildContext context) =>
        const CategoriaFormularioScreen(),
    'error': (BuildContext context) => const ErrorScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}