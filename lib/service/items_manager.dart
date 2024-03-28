import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/equipment_state.dart';

class ItemsManager {
  static final ItemsManager _instance = ItemsManager._internal();
  Map<String, Item> items = {};

  factory ItemsManager() {
    return _instance;
  }

  ItemsManager._internal();

  Future<Map<String, Item>> loadItems() async {
    String jsonString = await rootBundle.loadString('assets/config/items.json');
    var decode = json.decode(jsonString);
    decode.forEach((key, value) =>
        items.putIfAbsent(key, () => Item(value['name'], value['iconPath'])));
    return items;
  }
}
