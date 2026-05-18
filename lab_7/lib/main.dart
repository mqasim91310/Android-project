import 'package:flutter/material.dart';
import 'screens/recipe_list_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Book',
      theme: ThemeData(
        primaryColor: const Color(0xFFE53935),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE53935)),
        fontFamily: 'Roboto',
        useMaterial3: false,
      ),
      home: const RecipeListScreen(),
    );
  }
}