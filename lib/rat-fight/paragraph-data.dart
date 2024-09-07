import '../service/model/adventure_models.dart';

class ParagraphData {
  final String _welcomeText;
  final String _npcImg;
  final String _successText;
  final String _retryText;
  final String _failText;


  ParagraphData(this._welcomeText, this._npcImg,
      this._successText, this._retryText, this._failText);

  String get welcomeText => _welcomeText;

  String get npcImg => _npcImg;

  String get successText => _successText;

  String get retryText => _retryText;

  String get failText => _failText;


  factory ParagraphData.fromParagraph(Paragraph paragraph) {
    final itemCatcherDAta = paragraph.options;
    final welcomeText = itemCatcherDAta['welcomeText'];
    final npcImg = itemCatcherDAta['npcImg'];
    final successText = itemCatcherDAta['successText'];
    final retryText = itemCatcherDAta['retryText'];
    final failText = itemCatcherDAta['failText'];


    return ParagraphData(
        welcomeText, npcImg, successText, retryText, failText);
  }
}
