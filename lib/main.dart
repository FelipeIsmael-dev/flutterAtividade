import 'package:flutteratividade/pages/catalogo_page.dart';
import 'package:flutteratividade/providers/aluguel_provider.dart';
import 'package:flutteratividade/providers/chuteira_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChuteiraProvider()),
        ChangeNotifierProvider(create: (_) => AluguelProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aluga Chuteira',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      debugShowCheckedModeBanner: false,
      home: const CatalogoPage(),
    );
  }
}
