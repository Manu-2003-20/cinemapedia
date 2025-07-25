import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const ActorsByMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorInfoProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(7),
            width: 135,
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                FadeInRight(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                     height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/Reasons-Why-Images-Not-Loading-on-Your-Website-2.gif'),
                    image: NetworkImage(actor.profilePath),
                    
                  ),
                )),
                const SizedBox(
                  height: 5,
                ),
                Text(actor.name),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
