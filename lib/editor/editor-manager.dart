import 'dart:convert';

import 'package:darth_flutter/service/model/adventure_models.dart';

class EditorManager {
  static final EditorManager _instance = EditorManager._internal();
  late AdventureData adventureData;
  late String adventureDataAsJson;
  late String selectedParagraphId = '';

  factory EditorManager() {
    return _instance;
  }

  loadAdventureData(String data) {
    Map<String, dynamic> jsonMap = json.decode(data);
    AdventureData parsedData = AdventureData.fromJson(jsonMap);
    adventureData = parsedData;
    adventureDataAsJson = data;
  }

  selectedParagraphAdventureDataJson() {
    Paragraph paragraph = adventureData.paragraphs.firstWhere((paragraph) => paragraph.identifier == selectedParagraphId, orElse: () => Paragraph(identifier: selectedParagraphId, options: {}, text: '', type: ''));
    return JsonEncoder.withIndent(' ').convert(paragraph.toJson());
  }

  getParagraph(String id) {
    Paragraph paragraph = adventureData.paragraphs.firstWhere((paragraph) => paragraph.identifier == id, orElse: () => Paragraph(identifier: selectedParagraphId, options: {}, text: '', type: ''));
    return paragraph;
  }

  saveParagraphAdventure(String id, String data) {
    //todo
  }


  EditorManager._internal();
}