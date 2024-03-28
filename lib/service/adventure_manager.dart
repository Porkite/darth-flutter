import 'dart:convert';
import 'package:darth_flutter/service/model/adventure_models.dart';
import 'package:flutter/services.dart';

import 'items_manager.dart';

class AdventureManager {

  Future<AdventureData> loadGameData() async {
    String jsonString = await rootBundle.loadString('assets/adventures/dungeon.json');
    return parseGameData(jsonString);
  }

  AdventureData parseGameData(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AdventureData.fromJson(jsonMap);
  }

  Future<AdventureData> getAdventure() async {
    AdventureData gameData = await loadGameData();
    await ItemsManager().loadItems();
    return gameData;
  }
}
