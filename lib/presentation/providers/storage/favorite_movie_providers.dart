import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
        offset: page * 10, limit: 13); //TODO: limit 20
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  //TODO: remover de movies favoritas
  Future<void> toggleFavorites(Movie movie) async{
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if(isMovieInFavorites){
      state.remove(movie.id);
      // Usamos el spread operator `{...state}` para crear una nueva copia del estado, 
      state = {...state};
      //TODO: añadir a movies favoritas
    }else {
    // Si la película no estaba en la lista de favoritos (isMovieInFavorites es false):
    
    // Añade la película al estado actual.
    // Creamos una nueva copia del estado anterior y agregamos la película usando su `id` como clave.
    state = {...state, movie.id: movie};
  }
    
  }
}
