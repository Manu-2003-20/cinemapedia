import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';


abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getUpcoming({ int page = 1 });
  
  Future<List<Movie>> getTopRated({ int page = 1 });

  Future<Movie> getById(String id);

  Future<List<Movie>> getSearchMovies(String query);

  Future<List<Movie>> getSimilarMovies(int movieId);

  Future<List<Video>> getYouTubeVideosById(int movieId);

}