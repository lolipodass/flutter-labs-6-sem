class Game {
  final int id;
  final String title;
  final double rating;

  Game({required this.id, required this.title, required this.rating});

  factory Game.fromSqfliteDatabase(Map<String, dynamic> map) => Game(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      rating: map['rating']?.toDouble() ?? 0);
}
