
import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_video.dart';

class VideoMapper {

  static moviedbVideoToEntity( Result moviedbVideo ) => Video(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt
  );


}