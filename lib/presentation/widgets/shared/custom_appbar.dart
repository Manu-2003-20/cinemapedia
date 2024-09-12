import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/theme_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    // Obtenemos el modo actual del tema
    final themeMode = ref.watch(themeModeProvider);

    return FadeInRight(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Cinemapedia',
                style: titleStyle,
              ),
              const Spacer(),
              // Botón de búsqueda
              IconButton(
                  onPressed: () {
                    //!final searchMovies = ref.read(searchedMoviesProvider);
                    final movieRepository = ref.read(movieRepositoryProvider);
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(
                        query: searchQuery,
                        context: context,
                        delegate: SearchMovieDelegate(
                          searchMovies: (query) {
                            ref
                                .read(searchQueryProvider.notifier)
                                .update((state) => query);
                            return movieRepository.getSearchMovies(query);
                          },

                          //!searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                        )).then((movie) {
                      if (movie == null) return;
                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search)),
              const SizedBox(width: 5),
              // Botón de cambio de tema
              FadeInDown(
                key: ValueKey(themeMode),
                child: IconButton(
                  onPressed: () {
                    // Cambiamos entre tema claro y oscuro

                    ref.read(themeModeProvider.notifier).update((state) {
                      return state == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    });
                  },
                  icon: Icon(
                    themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
