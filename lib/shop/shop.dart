import 'package:darth_flutter/shop/potion.dart';

import '../service/model/adventure_models.dart';

class Shop {
  final String _welcomeText;
  final List<Potion> _potions;
  final String _assistantImg;

  Shop(this._welcomeText, this._potions, this._assistantImg);

  String get welcomeText => _welcomeText;

  List<Potion> get potions => _potions;

  String get assistantImg => _assistantImg;

  factory Shop.fromParagraph(Paragraph paragraph) {
    final shopData = paragraph.options;
    final welcomeText = shopData['welcomeText'];
    final assistantImg = shopData['assistantImg'];
    final potions = List<Potion>.from(
        shopData['potions'].map((potion) => Potion.fromJson(potion)));

    return Shop(welcomeText, potions, assistantImg);
  }
}
