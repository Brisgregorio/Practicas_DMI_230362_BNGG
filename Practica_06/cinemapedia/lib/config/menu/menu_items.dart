import 'package:cinemapedia/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum MenuItemLabel {
  counter,
  buttons,
  cards,
  progress,
  snackbars,
  animated,
  controls,
  tutorial,
  infinite,
  theme,
}

class MenuItem {
  final MenuItemLabel label;
  final String link;
  final IconData icon;

  const MenuItem({required this.label, required this.link, required this.icon});

  String title(AppLocalizations l10n) => switch (label) {
    MenuItemLabel.counter => l10n.counterMenuTitle,
    MenuItemLabel.buttons => l10n.buttonsMenuTitle,
    MenuItemLabel.cards => l10n.cardsMenuTitle,
    MenuItemLabel.progress => l10n.progressMenuTitle,
    MenuItemLabel.snackbars => l10n.snackbarsMenuTitle,
    MenuItemLabel.animated => l10n.animatedMenuTitle,
    MenuItemLabel.controls => l10n.controlsMenuTitle,
    MenuItemLabel.tutorial => l10n.tutorialMenuTitle,
    MenuItemLabel.infinite => l10n.infiniteMenuTitle,
    MenuItemLabel.theme => l10n.themeMenuTitle,
  };

  String subtitle(AppLocalizations l10n) => switch (label) {
    MenuItemLabel.counter => l10n.counterMenuSubtitle,
    MenuItemLabel.buttons => l10n.buttonsMenuSubtitle,
    MenuItemLabel.cards => l10n.cardsMenuSubtitle,
    MenuItemLabel.progress => l10n.progressMenuSubtitle,
    MenuItemLabel.snackbars => l10n.snackbarsMenuSubtitle,
    MenuItemLabel.animated => l10n.animatedMenuSubtitle,
    MenuItemLabel.controls => l10n.controlsMenuSubtitle,
    MenuItemLabel.tutorial => l10n.tutorialMenuSubtitle,
    MenuItemLabel.infinite => l10n.infiniteMenuSubtitle,
    MenuItemLabel.theme => l10n.themeMenuSubtitle,
  };
}

const appMenuItems = <MenuItem>[
  MenuItem(
    label: MenuItemLabel.counter,
    link: '/counter-river',
    icon: Icons.add,
  ),
  MenuItem(
    label: MenuItemLabel.buttons,
    link: '/buttons',
    icon: Icons.smart_button_outlined,
  ),
  MenuItem(label: MenuItemLabel.cards, link: '/cards', icon: Icons.credit_card),
  MenuItem(
    label: MenuItemLabel.progress,
    link: '/progress',
    icon: Icons.refresh_rounded,
  ),
  MenuItem(
    label: MenuItemLabel.snackbars,
    link: '/snackbars',
    icon: Icons.info_outline,
  ),
  MenuItem(
    label: MenuItemLabel.animated,
    link: '/animated',
    icon: Icons.check_box_outline_blank_rounded,
  ),
  MenuItem(
    label: MenuItemLabel.controls,
    link: '/ui-controls',
    icon: Icons.car_rental_outlined,
  ),
  MenuItem(
    label: MenuItemLabel.tutorial,
    link: '/tutorial',
    icon: Icons.accessible_rounded,
  ),
  MenuItem(
    label: MenuItemLabel.infinite,
    link: '/infinite',
    icon: Icons.list_alt_rounded,
  ),
  MenuItem(
    label: MenuItemLabel.theme,
    link: '/theme-changer',
    icon: Icons.color_lens_outlined,
  ),
];
