import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  //Estaba creando este parametro nulo
  //!get searchMovies => null;

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getById(String id) {
    return datasource.getById(id);
  }

  @override
  Future<List<Movie>> getSearchMovies(String query) {
    return datasource.getSearchMovies(query);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return datasource.getSimilarMovies(movieId);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return datasource.getYouTubeVideosById(movieId);
  }
}