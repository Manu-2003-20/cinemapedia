import 'package:flutter/material.dart';

class CategoriasViews extends StatelessWidget {
  const CategoriasViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: const Center(child:  Text('Categorias de movies'),),
    );
  }
}