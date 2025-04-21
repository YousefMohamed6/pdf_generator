import 'package:flutter/material.dart';
import 'package:pdf_generator/core/services/router_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp._();
  static const MyApp _instance = MyApp._();
  factory MyApp() => _instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PDF Generator',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: RouterManager.routeConfig,
    );
  }
}
