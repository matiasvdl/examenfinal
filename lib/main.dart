import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'routes/app_routes.dart';
import 'providers/producto_provider.dart';
import 'providers/proveedor_provider.dart';
import 'providers/categoria_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderState());
}

class ProviderState extends StatelessWidget {
  const ProviderState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductoProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProveedorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriaProvider(),
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 53, 71, 1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 53, 71, 1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 53, 71, 1),
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 53, 71, 1),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}