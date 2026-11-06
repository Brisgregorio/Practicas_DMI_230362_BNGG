import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              const Expanded(child: CinemapediaBrand()),

              IconButton(
                onPressed: () async {
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  final movie = await showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      localizations: l10n,
                      initialMovies: searchedMovies,
                      searchMovies: ref
                          .read(searchedMoviesProvider.notifier)
                          .searchMoviesByQuery,
                    ),
                  );
                  if (movie == null || !context.mounted) return;
                  context.push('/movie/${movie.id}');
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CinemapediaBrand extends StatelessWidget {
  final bool compact;
  final Color? foregroundColor;

  const CinemapediaBrand({
    super.key,
    this.compact = false,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icon/cinemapedia_logo.png',
          width: compact ? 27 : 32,
          height: compact ? 27 : 32,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            'Cinemapedia_230362',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titleStyle?.copyWith(
              color: foregroundColor,
              fontSize: compact ? 13 : null,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
