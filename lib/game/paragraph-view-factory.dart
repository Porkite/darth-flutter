import 'package:darth_flutter/game/equipment.dart';
import 'package:darth_flutter/game/text-type-widget.dart';
import 'package:darth_flutter/map/minimap-widget.dart';
import 'package:darth_flutter/quiz/quiz-view.dart';
import 'package:darth_flutter/rat-fight/rat-fight-view.dart';
import 'package:darth_flutter/service/game_manager.dart';
import 'package:darth_flutter/service/model/adventure_models.dart';
import 'package:darth_flutter/service/model/allowedMoves.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../item_catcher/item-catcher-view.dart';
import '../service/adventure_manager.dart';
import '../shop/shop-view.dart';

class ParagraphViewFactory {
  static Future<Widget> buildParagraphViewByIdentifier(BuildContext context, String identifier) async {
    AdventureData adventureData = await Provider.of<AdventureManager>(context, listen: false).getAdventure();
    if (GameManager().getEquipmentOpen()) {
      return const EquipmentWidget();
    } else if (GameManager.player.getMinimapOpen()) {
      return const MinimapWidget();
    }
    Paragraph paragraph = adventureData.getParagraphById(identifier);
    AllowedMoves allowedMoves = adventureData.getAllowedMovesById(identifier);
    GameManager().setAllowedMoves(allowedMoves);
    return _getWidgetByType(paragraph);
  }

  static Widget _getWidgetByType(Paragraph paragraph) {
    switch (paragraph.type) {
      case 'text':
        return TextTypeWidget(text: paragraph.text);
      case 'shop':
        return ShopWidget(paragraph: paragraph);
      case 'itemCatcher':
        return ItemCatcherWidget(paragraph: paragraph);
      case 'quizGame':
        return QuizViewWidget(paragraph: paragraph);
      case 'ratFight':
        return RatFightViewWidget(paragraph: paragraph);
      case 'error':
        return TextTypeWidget(text: paragraph.text);
      default:
        return const SizedBox();
    }
  }
}
