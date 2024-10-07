import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesViews extends ConsumerStatefulWidget {
  const FavoritesViews({super.key});

  @override
  FavoritesViewsState createState() => FavoritesViewsState();
}

class FavoritesViewsState extends ConsumerState<FavoritesViews> with AutomaticKeepAliveClientMixin  {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final color = Theme.of(context).colorScheme;
      return FadeInDown(
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
                Icon(Icons.favorite_outline_sharp,size: 60,color: color.primary,),
                Text('Ohhh no!!!',style: TextStyle(fontSize: 30,color: color.primary),),
                Text('No tienes películas Favoritas',style: TextStyle(fontSize: 20,color: color.secondary),),
        
        
                    const SizedBox(height: 20,),
                    FilledButton.tonal(onPressed: (){
                      context.go('/home/0');
                    }, child: const Text('Empieza a buscar'))
              ],
            )),
      );
    }

    return Scaffold(
        body:
            MoviesMasonry(loadNextPage: loadNextPage, movies: favoriteMovies));
  }
  
  @override
  bool get wantKeepAlive => true;
}
