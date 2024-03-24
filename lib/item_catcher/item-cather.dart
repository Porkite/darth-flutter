import '../service/model/adventure_models.dart';
import 'game-settings.dart';

class ItemCatcher {
  final String _welcomeText;
  final String _witchImg;
  final String _successText;
  final String _retryText;
  final String _failText;

  final GameSettings _gameSettings;

  ItemCatcher(this._welcomeText, this._witchImg, this._gameSettings,
      this._successText, this._retryText, this._failText);

  String get welcomeText => _welcomeText;

  String get witchImg => _witchImg;

  String get successText => _successText;

  String get retryText => _retryText;

  String get failText => _failText;

  GameSettings get gameSettings => _gameSettings;

  factory ItemCatcher.fromParagraph(Paragraph paragraph) {
    final itemCatcherDAta = paragraph.options;
    final welcomeText = itemCatcherDAta['welcomeText'];
    final witchImg = itemCatcherDAta['witchImg'];
    final successText = itemCatcherDAta['successText'];
    final retryText = itemCatcherDAta['retryText'];
    final failText = itemCatcherDAta['failText'];

    final gameSettings = GameSettings.fromJson(itemCatcherDAta['gameSettings']);

    return ItemCatcher(
        welcomeText, witchImg, gameSettings, successText, retryText, failText);
  }
}
