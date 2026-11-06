import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/config/constants/country_catalog.dart';
import 'package:cinemapedia/config/constants/cinema_country.dart';
import 'package:cinemapedia/config/helpers/localized_country.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:cinemapedia/presentation/providers/settings/cinema_country_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesSlideshow extends ConsumerStatefulWidget {
  final List<Movie> movies;
  final bool isLoading;
  final bool hasError;
  final VoidCallback? onRetry;

  const MoviesSlideshow({
    super.key,
    required this.movies,
    this.isLoading = false,
    this.hasError = false,
    this.onRetry,
  });

  @override
  ConsumerState<MoviesSlideshow> createState() => _MoviesSlideshowState();
}

class _MoviesSlideshowState extends ConsumerState<MoviesSlideshow> {
  final SwiperController swiperController = SwiperController();
  int currentIndex = 0;

  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
  }

  String certification(Movie movie, CinemaCountry country) =>
      movie.adult ? country.adultCertification : '${country.certification}*';

  void showBoundaryMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1100),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF51418F),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (widget.movies.isEmpty) {
      return SizedBox(
        height: 280,
        child: Center(
          child: widget.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.hasError
                          ? Icons.cloud_off_rounded
                          : Icons.movie_filter_outlined,
                      color: Colors.white60,
                      size: 32,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.hasError
                          ? l10n.noMoviesFailed
                          : l10n.noMoviesCountry,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    if (widget.hasError && widget.onRetry != null) ...[
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: widget.onRetry,
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text(l10n.retry),
                      ),
                    ],
                  ],
                ),
        ),
      );
    }

    final country = ref.watch(selectedCinemaCountryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.countryRatingTitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${flagForCountry(country.code)}  ${localizedCountryName(l10n, country)} · ${country.language}',
                style: const TextStyle(
                  color: Color(0xFFB9A6FF),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 340,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Swiper(
                controller: swiperController,
                viewportFraction: 0.78,
                scale: 0.88,
                autoplay: true,
                autoplayDelay: 4800,
                loop: false,
                onIndexChanged: (index) {
                  setState(() => currentIndex = index);
                  if (index == 0) {
                    showBoundaryMessage(l10n.atListStart);
                  } else if (index == widget.movies.length - 1) {
                    showBoundaryMessage(l10n.atListEnd);
                  }
                },
                pagination: const SwiperPagination(
                  margin: EdgeInsets.only(top: 0),
                  builder: DotSwiperPaginationBuilder(
                    activeColor: Color(0xFFAA91FF),
                    color: Color(0xFF52618D),
                  ),
                ),
                itemCount: widget.movies.length,
                itemBuilder: (context, index) => _MovieCarouselCard(
                  movie: widget.movies[index],
                  countryName: localizedCountryName(l10n, country),
                  countryCode: country.code,
                  countryFlag: flagForCountry(country.code),
                  rating: certification(widget.movies[index], country),
                ),
              ),
              if (widget.movies.length > 1) ...[
                PositionedDirectional(
                  start: 8,
                  child: _CarouselArrow(
                    icon: Directionality.of(context) == TextDirection.rtl
                        ? Icons.chevron_right_rounded
                        : Icons.chevron_left_rounded,
                    tooltip: l10n.previousMovie,
                    enabled: currentIndex > 0,
                    onPressed: () {
                      if (currentIndex > 0) swiperController.previous();
                    },
                    onDoublePressed: () => swiperController.move(
                      currentIndex == widget.movies.length - 1
                          ? 0
                          : widget.movies.length - 1,
                    ),
                  ),
                ),
                PositionedDirectional(
                  end: 8,
                  child: _CarouselArrow(
                    icon: Directionality.of(context) == TextDirection.rtl
                        ? Icons.chevron_left_rounded
                        : Icons.chevron_right_rounded,
                    tooltip: l10n.nextMovie,
                    enabled: currentIndex < widget.movies.length - 1,
                    onPressed: () {
                      if (currentIndex < widget.movies.length - 1) {
                        swiperController.next();
                      }
                    },
                    onDoublePressed: () => swiperController.move(
                      currentIndex == widget.movies.length - 1
                          ? 0
                          : widget.movies.length - 1,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 8),
          child: Center(
            child: Text(
              l10n.swipeExplore(currentIndex + 1, widget.movies.length),
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            l10n.ratingDisclaimer,
            style: const TextStyle(color: Colors.white38, fontSize: 10),
          ),
        ),
      ],
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool enabled;
  final VoidCallback onPressed;
  final VoidCallback onDoublePressed;

  const _CarouselArrow({
    required this.icon,
    required this.tooltip,
    required this.enabled,
    required this.onPressed,
    required this.onDoublePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        enabled: true,
        label: tooltip,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onPressed,
          onDoubleTap: onDoublePressed,
          child: Material(
            color: Colors.black.withValues(alpha: 0.38),
            shape: const CircleBorder(),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Icon(
                icon,
                size: 32,
                color: enabled ? Colors.white : Colors.white38,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieCarouselCard extends StatelessWidget {
  final Movie movie;
  final String countryName;
  final String countryCode;
  final String countryFlag;
  final String rating;

  const _MovieCarouselCard({
    required this.movie,
    required this.countryName,
    required this.countryCode,
    required this.countryFlag,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [Color(0xFF292451), Color(0xFF172D50)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 14,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: const Color(0x667F70C8)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.backdropPath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: const Color(0xFF25264F),
                        child: const Icon(
                          Icons.movie,
                          size: 50,
                          color: Colors.white38,
                        ),
                      ),
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                          ? FadeIn(child: child)
                          : Container(
                              color: const Color(0xFF25264F),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xEE10132F)],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.selectedLanguageTitle,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              shadows: [
                                Shadow(color: Colors.black87, blurRadius: 8),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context)!.originalTitleLanguage(
                              movie.originalLanguage.toUpperCase(),
                            ),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            movie.originalTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(color: Colors.black87, blurRadius: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 10, 13, 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFD166),
                      size: 19,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Color(0xFFFFD166),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8069D9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$countryFlag $countryCode · $rating',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 0, 13, 10),
                child: Text(
                  AppLocalizations.of(context)!
                      .selectedRatingCountry(countryName),
                  style: const TextStyle(color: Colors.white60, fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
