class Board {
  String id;
  List<String> positions;

  Board({
    required this.id,
    required this.positions,
  });

  factory Board.empty() => Board(id: "", positions: List.filled(9, ""));
}
