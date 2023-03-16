class Player {
  String? id;
  String name;
  int points;
  bool isCurrent;

  Player({
    required this.id,
    required this.name,
    required this.points,
    required this.isCurrent,
  });

  factory Player.empty(String name) => Player(id: '', name: name, isCurrent: false, points: 0);

  factory Player.fromJson(Map<String, dynamic> json, bool isCurrent) => Player(
        id: json['id'],
        name: json['name'],
        points: int.tryParse(json['points'] ?? '') ?? 0,
        isCurrent: isCurrent,
      );
}
