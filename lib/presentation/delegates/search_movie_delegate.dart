import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/humans_formats.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  static const searchMovie = 'movie-search';

  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies});

  void clearStreams(){
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    print('Query String cambio');
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {

      if(query.isEmpty){
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      return debouncedMovies.add(movies);


    });
  }

  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    //if(query.isNotEmpty)
    {
      return [
        FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)))
      ];
    }
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      //future: searchMovies(query),
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        //! print('Realizando peticion');

        final movies = snapshot.data ?? [];

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(
                  movie: movies[index],
                  onMovieSelected: (context,movies){
                    clearStreams();
                    close(context, movies);
                  },
                ));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      movie.posterPath,
                      loadingBuilder: (context, child, loadingProgress) =>
                          FadeIn(child: child),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium,
                  ),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        HumansFormats.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade800),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
