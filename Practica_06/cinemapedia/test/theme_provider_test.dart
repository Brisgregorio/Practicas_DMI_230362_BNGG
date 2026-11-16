import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light and dark themes keep text and primary actions legible', () {
    final lightTheme = AppTheme(isDarkmode: false).getTheme();
    final darkTheme = AppTheme().getTheme();

    expect(
      _contrastRatio(
        lightTheme.textTheme.titleLarge!.color!,
        lightTheme.scaffoldBackgroundColor,
      ),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrastRatio(
        lightTheme.textTheme.bodySmall!.color!,
        lightTheme.scaffoldBackgroundColor,
      ),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrastRatio(
        darkTheme.textTheme.bodyMedium!.color!,
        darkTheme.colorScheme.surface,
      ),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrastRatio(
        darkTheme.textTheme.bodySmall!.color!,
        darkTheme.colorScheme.surface,
      ),
      greaterThanOrEqualTo(4.5),
    );

    for (var index = 0; index < colorList.length; index++) {
      final color = colorList[index];
      final selectedTheme = AppTheme(
        isDarkmode: false,
        selectedColor: index,
      ).getTheme();
      expect(
        _contrastRatio(
          selectedTheme.colorScheme.onPrimary,
          color,
        ),
        greaterThanOrEqualTo(4.5),
      );
    }
  });

  test('theme notifier updates brightness and selected primary color', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(themeNotifierProvider).isDarkmode, isTrue);
    expect(
      container.read(themeNotifierProvider).getTheme().brightness,
      Brightness.dark,
    );

    container.read(themeNotifierProvider.notifier).toggleDarkmode();
    expect(container.read(themeNotifierProvider).isDarkmode, isFalse);
    expect(
      container.read(themeNotifierProvider).getTheme().brightness,
      Brightness.light,
    );

    final selectedColor = container.read(colorListProvider)[1];
    container.read(themeNotifierProvider.notifier).changeColorIndex(1);
    expect(
      container.read(themeNotifierProvider).getTheme().colorScheme.primary,
      selectedColor,
    );
  });
}

double _contrastRatio(Color first, Color second) {
  final firstLuminance = first.computeLuminance();
  final secondLuminance = second.computeLuminance();
  final lighter = firstLuminance > secondLuminance
      ? firstLuminance
      : secondLuminance;
  final darker = firstLuminance > secondLuminance
      ? secondLuminance
      : firstLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}
