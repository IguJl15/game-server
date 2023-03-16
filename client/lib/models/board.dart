class Board {
  String id;
  List<String> positions;

  Board({
    required this.id,
    required this.positions,
  });

  factory Board.empty() => Board(id: '', positions: List.filled(9, ''));

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        id: json['boardId'],
        positions: (json['squares'] as List).map<String>((e) => e['value'] ?? '').toList(),
      );
}
