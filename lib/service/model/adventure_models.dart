class MapData {
  final List<String> mapRows;
  final String fileNamesInSequence;
  final String rankNamesInSequence;

  MapData({
    required this.mapRows,
    required this.fileNamesInSequence,
    required this.rankNamesInSequence,
  });

  factory MapData.fromJson(Map<String, dynamic> json) {
    return MapData(
      mapRows: List<String>.from(json['map']['mapRows']),
      fileNamesInSequence: json['map']['fileNamesInSequence'],
      rankNamesInSequence: json['map']['rankNamesInSequence'],
    );
  }
}

class Paragraph {
  final String identifier;
  final Map<String, dynamic> options;
  final String text;

  Paragraph({
    required this.identifier,
    required this.options,
    required this.text,
  });

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(
      identifier: json['identifier'],
      options: json['options'],
      text: json['text'],
    );
  }
}

class AdventureData {
  final MapData mapData;
  final List<Paragraph> paragraphs;

  AdventureData({
    required this.mapData,
    required this.paragraphs,
  });

  factory AdventureData.fromJson(Map<String, dynamic> json) {
    return AdventureData(
      mapData: MapData.fromJson(json),
      paragraphs: List<Paragraph>.from(json['paragraphs'].map((x) => Paragraph.fromJson(x))),
    );
  }
}