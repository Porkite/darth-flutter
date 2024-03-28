import 'package:darth_flutter/game/equipment.dart';
import 'package:darth_flutter/service/model/coordinates.dart';
import 'package:darth_flutter/service/model/equipment_state.dart';

import 'direction.dart';

class Player {
  final Coordinates coordinates;
  final EquipmentState equipment;

  Player(this.coordinates, this.equipment);

  move(Direction direction) {
    if (direction == Direction.NORTH) {
      coordinates.y = (int.parse(coordinates.y) - 1).toString();
    } else if (direction == Direction.SOUTH) {
      coordinates.y = (int.parse(coordinates.y) + 1).toString();
    } else if (direction == Direction.WEST) {
      coordinates.x = String.fromCharCode(coordinates.x.codeUnitAt(0) + 1);
    } else if (direction == Direction.EAST) {
      coordinates.x = String.fromCharCode(coordinates.x.codeUnitAt(0) - 1);
    }
  }

  String getPlayerPositionId() {
    return coordinates.x + coordinates.y;
  }

  EquipmentState getPlayerEquipment() {
    return equipment;
  }
}
