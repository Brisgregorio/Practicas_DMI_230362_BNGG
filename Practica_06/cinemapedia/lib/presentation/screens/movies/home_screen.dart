import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  final int pageIndex;
  final String? section;

  const HomeScreen({super.key, this.pageIndex = 0, this.section});

  @override
  Widget build(BuildContext context) => IndexedStack(
    index: pageIndex.clamp(0, 2).toInt(),
    children: [
      HomeView(section: section),
      const CategoriesView(),
      const FavoritesView(),
    ],
  );
}
