import 'dart:convert';

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

  Paragraph getParagraphById(String identifier){
    return paragraphs.firstWhere((element) => element.identifier == identifier,
    orElse: () => new Paragraph(identifier: '', options: {}, text: 'Jesteś w miejscu, w którym być nie powinieneś', type: 'error'));
  }
}
