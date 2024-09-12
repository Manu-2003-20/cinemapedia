import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorRepository{
  Future <List<Actor>> getActorMovie(String movieId);
}