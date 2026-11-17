import 'package:cinemapedia/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TvSeriesGrid extends StatelessWidget {
  final List<TvSeries> series;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final double childAspectRatio;

  const TvSeriesGrid({
    super.key,
    required this.series,
    this.shrinkWrap = false,
    this.physics,
    this.childAspectRatio = 0.68,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(14),
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: series.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final item = series[index];
        return Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () => context.push('/series/${item.id}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    item.posterPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.live_tv_outlined, size: 40),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(9, 8, 9, 4),
                  child: Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(9, 0, 9, 8),
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber.shade600),
                      const SizedBox(width: 4),
                      Text(item.voteAverage.toStringAsFixed(1)),
                      const Spacer(),
                      if (item.firstAirDate case final firstAirDate?)
                        Text(firstAirDate.year.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
