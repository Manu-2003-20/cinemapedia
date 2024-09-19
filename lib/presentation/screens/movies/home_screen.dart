import 'package:cinemapedia/presentation/views/movies/categorias_views.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRouter = const <Widget>[
    HomeView(),
    CategoriasViews(),
    FavoritesViews()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRouter,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex,),
    );
  }
}
