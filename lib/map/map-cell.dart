class MapCell {
  final int xPos;
  final int yPos;
  final String key;
  final String description;
  final String? npcImg;

  MapCell({required this.xPos, required this.yPos, required this.key, required this.description, this.npcImg});
}