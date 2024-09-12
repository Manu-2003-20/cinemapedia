import 'package:cinemapedia/domain/datasources/actor_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl extends ActorRepository{

  final ActorDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorMovie(String movieId) {
    return datasource.getActorMovie(movieId);
  }

}