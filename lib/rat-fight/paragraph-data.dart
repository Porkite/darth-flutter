import '../service/model/adventure_models.dart';

class ParagraphData {
  final String _welcomeText;
  final String _npcImg;
  final String _entryText;
  final String _entryFightButton;
  final String _entryChickenText;
  final String _entryGivenMoneyText;
  final String _entryNoMoneyText;
  final String _entryDanceText;
  final String _entryOkText;
  final String _loseText;
  final String _loseButton;
  final String _winText;

  ParagraphData(
      this._welcomeText,
      this._npcImg,
      this._entryText,
      this._entryFightButton,
      this._entryChickenText,
      this._entryGivenMoneyText,
      this._entryNoMoneyText,
      this._entryDanceText,
      this._entryOkText,
      this._loseText,
      this._loseButton,
      this._winText);

  String get welcomeText => _welcomeText;

  String get npcImg => _npcImg;

  String get entryText => _entryText;

  String get entryFightButton => _entryFightButton;

  String get entryChickenText => _entryChickenText;

  String get entryGivenMoneyText => _entryGivenMoneyText;

  String get entryNoMoneyText => _entryNoMoneyText;

  String get entryDanceText => _entryDanceText;

  String get entryOkText => _entryOkText;

  String get loseText => _loseText;

  String get loseButton => _loseButton;

  String get winText => _winText;

  factory ParagraphData.fromParagraph(Paragraph paragraph) {
    final ratFightData = paragraph.options;

    final welcomeText = paragraph.text;
    final npcImg = ratFightData['npcImg'];
    final entryText = ratFightData['entryText'];
    final entryFightButton = ratFightData['entryFightButton'];
    final entryChickenText = ratFightData['entryChickenText'];
    final entryGivenMoneyText = ratFightData['entryGivenMoneyText'];
    final entryNoMoneyText = ratFightData['entryNoMoneyText'];
    final entryDanceText = ratFightData['entryDanceText'];
    final entryOkText = ratFightData['entryOkText'];
    final loseText = ratFightData['loseText'];
    final loseButton = ratFightData['loseButton'];
    final winText = ratFightData['winText'];

    return ParagraphData(
        welcomeText,
        npcImg,
        entryText,
        entryFightButton,
        entryChickenText,
        entryGivenMoneyText,
        entryNoMoneyText,
        entryDanceText,
        entryOkText,
        loseText,
        loseButton,
        winText);
  }
}
