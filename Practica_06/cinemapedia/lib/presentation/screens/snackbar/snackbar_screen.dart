import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/l10n/app_localizations.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).clearSnackBars();

    final snakback = SnackBar(
      content: Text(l10n.helloWorld),
      action: SnackBarAction(label: l10n.ok, onPressed: () {}),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snakback);
  }

  void openDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.areYouSure),
        content: Text(l10n.demoDialogMessage),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text(l10n.cancel)),

          FilledButton(
            onPressed: () => context.pop(),
            child: Text(l10n.accept),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.snackbarsScreenTitle)),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [Text(l10n.demoAboutMessage)],
                );
              },
              child: Text(l10n.usedLicenses),
            ),

            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: Text(l10n.showDialog),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Text(l10n.showSnackbar),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
