import 'dart:convert';

import 'package:darth_flutter/service/model/adventure_models.dart';

class EditorManager {
  static final EditorManager _instance = EditorManager._internal();
  late AdventureData adventureData;
  late String adventureDataAsJson;

  factory EditorManager() {
    return _instance;
  }

  loadAdventureData(String data) {
    Map<String, dynamic> jsonMap = json.decode(data);
    AdventureData parsedData = AdventureData.fromJson(jsonMap);
    adventureData = parsedData;
    adventureDataAsJson = data;
  }

  EditorManager._internal();
}