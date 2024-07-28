import 'package:darth_flutter/service/game_manager.dart';
import 'package:tuple/tuple.dart';
import '../player/player.dart';
import 'map-cell.dart';
import 'package:darth_flutter/service/model/adventure_models.dart';

class MinimapService {
  late final List<MapCell> _mapCells;
  late final int _minX;
  late final int _minY;
  late final int _maxX;
  late final int _maxY;

  void initialize(AdventureData adventureData) {
    try {
      var mappedRes = mapToCells(adventureData);
      _mapCells = mappedRes.item1;
      _minX = mappedRes.item2;
      _minY = mappedRes.item3;
      _maxX = mappedRes.item4;
      _maxY = mappedRes.item5;
    } catch (e) {
      print(e);
    }
  }

  int countRows(List<String> identifiers) {
    final Set<String> uniqueLetters = {};
    for (var id in identifiers) {
      if (id.isNotEmpty) {
        uniqueLetters.add(id[1]);
      }
    }
    return uniqueLetters.length;
  }

  int countColumns(List<String> identifiers) {
    int maxNumber = 0;
    for (var id in identifiers) {
      String numberPart = id.substring(1);
      if (numberPart.isNotEmpty) {
        int number = int.parse(numberPart);
        if (number > maxNumber) {
          maxNumber = number;
        }
      }
    }
    return maxNumber;
  }

  Tuple5<List<MapCell>, int, int, int, int> mapToCells(
      AdventureData adventureData) {
    List<MapCell> map = [];
    int minX = 9999999; // Initialize with a large integer value
    int minY = 9999999; // Initialize with a large integer value
    int maxX = 0;
    int maxY = 0;

    for (var i in adventureData.paragraphIdentifiers) {
      var decodedX = i.codeUnitAt(0) - 96;
      var decodedY = int.parse(i.substring(1));

      if (decodedX < minX) minX = decodedX;
      if (decodedY < minY) minY = decodedY;
      if (decodedX > maxX) maxX = decodedX;
      if (decodedY > maxY) maxY = decodedY;

      Paragraph paragraph = adventureData.paragraphs
          .firstWhere((element) => element.identifier == i);

      map.add(MapCell(
          xPos: decodedX,
          yPos: decodedY,
          key: i,
          description: paragraph.text,
          npcImg: paragraph.options.containsKey('npcImg')
              ? adventureData.paragraphs
                  .firstWhere((element) => element.identifier == i)
                  .options['npcImg'] as String?
              : null));
    }
    return Tuple5(map, minX, minY, maxX, maxY);
  }

  void teleportToId(String positionId) {
    Player().addCoins(-30);
    GameManager().setPlayerPosition(positionId);
  }

  // Getters
  List<MapCell> get mapCells => _mapCells;
  int get minX => _minX;
  int get minY => _minY;
  int get maxX => _maxX;
  int get maxY => _maxY;
}
