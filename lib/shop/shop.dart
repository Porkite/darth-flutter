import 'package:darth_flutter/shop/potion.dart';

import '../service/model/adventure_models.dart';

class Shop {
  final String _welcomeText;
  final List<Potion> _potions;
  final String _npcImg;

  Shop(this._welcomeText, this._potions, this._npcImg);

  String get welcomeText => _welcomeText;

  List<Potion> get potions => _potions;

  String get npcImg => _npcImg;

  factory Shop.fromParagraph(Paragraph paragraph) {
    final shopData = paragraph.options;
    final welcomeText = shopData['welcomeText'];
    final npcImg = shopData['npcImg'];
    final potions = List<Potion>.from(
        shopData['potions'].map((potion) => Potion.fromJson(potion)));

    return Shop(welcomeText, potions, npcImg);
  }
}
