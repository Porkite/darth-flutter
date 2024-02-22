import 'dart:convert';
import 'package:darth_flutter/service/model/adventure_models.dart';
import 'package:flutter/services.dart';

class AdventureManager {

  Future<AdventureData> loadGameData() async {
    String jsonString = await rootBundle.loadString('assets/adventures/dungeon.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AdventureData.fromJson(jsonMap);
  }

  Future<AdventureData> getAdventure() async {
    AdventureData gameData = await loadGameData();
    return gameData;
  }

}
