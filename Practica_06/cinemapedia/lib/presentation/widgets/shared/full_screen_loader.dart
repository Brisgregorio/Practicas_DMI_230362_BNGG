import 'package:flutter/material.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages(AppLocalizations l10n) {
    final messages = <String>[
      l10n.loadingMovies,
      l10n.gettingPopcorn,
      l10n.loadingPopular,
      l10n.callingGirlfriend,
      l10n.almostThere,
      l10n.takingLonger,
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(l10n.pleaseWait),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMessages(l10n),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text(l10n.loading);

              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
