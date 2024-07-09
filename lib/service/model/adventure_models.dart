import 'allowedMoves.dart';

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
      mapRows: List<String>.from(json['mapData']['mapRows']),
      fileNamesInSequence: json['mapData']['fileNamesInSequence'],
      rankNamesInSequence: json['mapData']['rankNamesInSequence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mapRows': mapRows,
      'fileNamesInSequence': fileNamesInSequence,
      'rankNamesInSequence': rankNamesInSequence,
    };
  }
}

class Paragraph {
  final String identifier;
  final Map<String, dynamic> options;
  final String text;
  final String type;

  Paragraph({
    required this.identifier,
    required this.options,
    required this.text,
    required this.type,
  });

  factory Paragraph.fromJson(Map<String, dynamic> json) {
    return Paragraph(
      identifier: json['identifier'],
      options: json['options'],
      text: json['text'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'options': options,
    'text': text,
    'type': type,
  };
}

class AdventureData {
  final MapData mapData;
  final List<Paragraph> paragraphs;
  final List<String> paragraphIdentifiers;

  AdventureData({
    required this.mapData,
    required this.paragraphs,
  }) : paragraphIdentifiers = paragraphs.map((p) => p.identifier).toList();

  factory AdventureData.fromJson(Map<String, dynamic> json) {
    return AdventureData(
      mapData: MapData.fromJson(json),
      paragraphs: List<Paragraph>.from(json['paragraphs'].map((x) => Paragraph.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mapData': mapData.toJson(),
      'paragraphs': paragraphs.map((paragraph) => paragraph.toJson()).toList(),
    };
  }

  Paragraph getParagraphById(String identifier){
    return paragraphs.firstWhere((element) => element.identifier == identifier,
    orElse: () => new Paragraph(identifier: '', options: {}, text: 'Jesteś w miejscu, w którym być nie powinieneś', type: 'error'));
  }

  AllowedMoves getAllowedMovesById(String identifier){
    bool north = paragraphIdentifiers.contains(identifier[0] + (int.parse(identifier[1]) - 1).toString());
    bool south = paragraphIdentifiers.contains(identifier[0] + (int.parse(identifier[1]) + 1).toString());
    bool east = paragraphIdentifiers.contains(String.fromCharCode(identifier.codeUnitAt(0) - 1) + identifier[1]);
    bool west = paragraphIdentifiers.contains(String.fromCharCode(identifier.codeUnitAt(0) + 1) + identifier[1]);
    return AllowedMoves(north: north, south: south, east: east, west: west);
  }

}
