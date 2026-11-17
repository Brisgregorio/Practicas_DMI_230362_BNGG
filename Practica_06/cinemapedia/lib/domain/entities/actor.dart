class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String? character;
  final int? order;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
    this.order,
  });
}
