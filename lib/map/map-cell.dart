class MapCell {
  final int _xPos;
  final int _yPos;
  final String _key;
  final String _description;
  final String? _npcImg;

  MapCell({
    required int xPos,
    required int yPos,
    required String key,
    required String description,
    String? npcImg,
  })  : _xPos = xPos,
        _yPos = yPos,
        _key = key,
        _description = description,
        _npcImg = npcImg;

  // Getters
  int get xPos => _xPos;
  int get yPos => _yPos;
  String get key => _key;
  String get description => _description;
  String? get npcImg => _npcImg;
}
