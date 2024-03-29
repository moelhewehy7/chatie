import 'package:chatie/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Chatie());
}

class Chatie extends StatelessWidget {
  const Chatie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo, brightness: Brightness.dark),
          useMaterial3: true),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomeView(),
    );
  }
}
