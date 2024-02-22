import 'package:darth_flutter/game/text-type-widget.dart';
import 'package:darth_flutter/service/model/adventure_models.dart';
import 'package:flutter/cupertino.dart';

import '../service/adventure_manager.dart';
import '../shop/shop.dart';

class ParagraphViewFactory {
  static Future<Widget> buildParagraphViewByIdentifier(String identifier) async {
    AdventureData adventureData = await AdventureManager().getAdventure();
    Paragraph paragraph = adventureData.getParagraphById(identifier);

    return _getWidgetByType(paragraph);
  }

  static Widget _getWidgetByType(Paragraph paragraph) {
    switch (paragraph.type) {
      case 'text':
        return TextTypeWidget(text: paragraph.text);
      case 'shop':
        return Shop(text: paragraph.text);
      default:
        return SizedBox();
    }
  }
}
