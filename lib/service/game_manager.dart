import 'package:darth_flutter/service/model/coordinates.dart';
import 'package:darth_flutter/service/model/equipment_state.dart';

import 'model/direction.dart';
import 'model/player_models.dart';

class GameManager {
  static final GameManager _instance = GameManager._internal();
  static final Player player =
      Player(Coordinates('b', '2'), EquipmentState.initializeEquipment());

  factory GameManager() {
    return _instance;
  }

  GameManager._internal();

  void changePlayerPosition(Direction direction) {
    player.move(direction);
  }

  String getPlayerPositionId() {
    return player.getPlayerPositionId();
  }

  EquipmentState getPlayerEquipment() {
    return player.getPlayerEquipment();
  }
}