import 'dart:convert';

import 'package:darth_flutter/service/model/adventure_models.dart';

class EditorManager {
  static final EditorManager _instance = EditorManager._internal();
  late AdventureData adventureData;
  late String selectedParagraphId = '';

  factory EditorManager() {
    return _instance;
  }

  loadAdventureData(String data) {
    Map<String, dynamic> jsonMap = json.decode(data);
    AdventureData parsedData = AdventureData.fromJson(jsonMap);
    adventureData = parsedData;
  }

  selectedParagraphAdventureDataJson() {
    Paragraph paragraph = adventureData.paragraphs.firstWhere((paragraph) => paragraph.identifier == selectedParagraphId, orElse: () => Paragraph(identifier: selectedParagraphId, options: {}, text: '', type: ''));
    return JsonEncoder.withIndent(' ').convert(paragraph.toJson());
  }

  String getAdventureDataAsJson() {
    return JsonEncoder.withIndent(' ').convert(adventureData.toJson());
  }

  getParagraph(String id) {
    Paragraph paragraph = adventureData.paragraphs.firstWhere((paragraph) => paragraph.identifier == id, orElse: () => Paragraph(identifier: selectedParagraphId, options: {}, text: '', type: ''));
    return paragraph;
  }

  saveParagraphAdventure(String id, String data) {
    Paragraph paragraphData = Paragraph.fromJson(json.decode(data));
    int index = adventureData.paragraphs.indexWhere((paragraph) => paragraph.identifier == id);
    if (index != -1) {
      adventureData.paragraphs[index] = paragraphData;
    }
  }

  EditorManager._internal();
}