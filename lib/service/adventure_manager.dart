import 'dart:async';
import 'dart:convert';
import 'package:darth_flutter/service/model/adventure_models.dart';
import 'package:flutter/services.dart';

import '../map/minimap-service.dart';
import 'items_manager.dart';

class AdventureManager {
  final MinimapService _minimapService;
  late final AdventureData _adventureData;
  final Completer<void> _adventureManagerCompleter = Completer<void>();

  AdventureManager(this._minimapService){
    _initialize();
  }

  Future<void> _initialize() async {
    _adventureData = await loadGameData();
    await ItemsManager().loadItems();
    _minimapService.initialize(_adventureData);
    _adventureManagerCompleter.complete();
  }

  Future<AdventureData> loadGameData() async {
    String jsonString = await rootBundle.loadString('assets/adventures/dungeon.json');
    return parseGameData(jsonString);
  }

  AdventureData parseGameData(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AdventureData.fromJson(jsonMap);
  }

  Future<AdventureData> getAdventure() async {
    await _adventureManagerCompleter.future;
    return _adventureData;
  }
}

