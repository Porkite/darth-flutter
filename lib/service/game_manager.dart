import 'package:darth_flutter/service/model/coordinates.dart';

import 'model/direction.dart';

class GameManager {
  static final GameManager _instance = GameManager._internal();
  Coordinates playerCoordinates = Coordinates('b', '2');

  factory GameManager() {
    return _instance;
  }

  GameManager._internal();

  void changePlayerPosition(Direction direction) {
    if (direction == Direction.NORTH) {
      playerCoordinates.y = (int.parse(playerCoordinates.y) - 1).toString();
    } else if (direction == Direction.SOUTH) {
      playerCoordinates.y = (int.parse(playerCoordinates.y) + 1).toString();
    } else if (direction == Direction.WEST) {
      playerCoordinates.x = String.fromCharCode(playerCoordinates.x.codeUnitAt(0) + 1);
    } else if (direction == Direction.EAST) {
      playerCoordinates.x = String.fromCharCode(playerCoordinates.x.codeUnitAt(0) - 1);
    }
  }

  String getPlayerPosition() {
    return playerCoordinates.x + playerCoordinates.y;
  }
}