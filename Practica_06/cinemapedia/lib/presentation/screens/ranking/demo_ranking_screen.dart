import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DemoRankingScreen extends StatelessWidget {
  static const name = 'demo-ranking';

  const DemoRankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    const entries = [120, 85, 40];
    const rankColors = [
      Color(0xFFFFC857),
      Color(0xFFC5CAD3),
      Color(0xFFCD7F5C),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.rankingTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.primary),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.demoDataLabel,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(l10n.demoDataDescription),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (var index = 0; index < entries.length; index++)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: rankColors[index].withValues(alpha: 0.18),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: rankColors[index],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(l10n.demoProfile(index + 1)),
                trailing: Text(
                  l10n.demoPoints(entries[index]),
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
