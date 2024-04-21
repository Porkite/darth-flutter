import 'package:darth_flutter/service/model/coordinates.dart';
import 'package:flutter/cupertino.dart';

import 'model/direction.dart';

class GameManager with ChangeNotifier {
  static final GameManager _instance = GameManager._internal();
  Coordinates playerCoordinates = Coordinates('b', '2');
  Coordinates _previousPlayerCoordinates = Coordinates('0', '0');
  factory GameManager() {
    return _instance;
  }

  GameManager._internal();

  void changePlayerPosition(Direction direction) {
    _previousPlayerCoordinates = Coordinates.from(playerCoordinates);
    if (direction == Direction.NORTH) {
      playerCoordinates.y = (int.parse(playerCoordinates.y) - 1).toString();
    } else if (direction == Direction.SOUTH) {
      playerCoordinates.y = (int.parse(playerCoordinates.y) + 1).toString();
    } else if (direction == Direction.WEST) {
      playerCoordinates.x = String.fromCharCode(playerCoordinates.x.codeUnitAt(0) + 1);
    } else if (direction == Direction.EAST) {
      playerCoordinates.x = String.fromCharCode(playerCoordinates.x.codeUnitAt(0) - 1);
    }
    notifyListeners();
  }

  void setPreviousPlayerPosition(){
    playerCoordinates = Coordinates.from(_previousPlayerCoordinates);
    _previousPlayerCoordinates = Coordinates('0', '0');
    notifyListeners();
  }

  void setPlayerPosition(Coordinates coordinates) {
    _previousPlayerCoordinates = Coordinates.from(playerCoordinates);
    playerCoordinates = coordinates;
    notifyListeners();
  }

  String getPlayerPositionId() {
    return playerCoordinates.x + playerCoordinates.y;
  }
}