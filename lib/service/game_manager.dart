import 'package:darth_flutter/service/model/coordinates.dart';
import 'package:darth_flutter/service/model/equipment_state.dart';
import 'package:darth_flutter/service/model/special-widget.dart';
import 'package:flutter/cupertino.dart';

import 'model/allowedMoves.dart';
import 'model/direction.dart';
import 'model/player_models.dart';

class GameManager with ChangeNotifier {
  static final GameManager _instance = GameManager._internal();
  static final Player player =
      Player(Coordinates('b', '2'), EquipmentState.initializeEquipment());

  factory GameManager() {
    return _instance;
  }

  GameManager._internal();

  void changePlayerPosition(Direction direction) {
    player.move(direction);
    notifyListeners();
  }

  void setPlayerPosition(String positionId){
    player.setPlayerPosition(Coordinates(positionId[0], positionId[1]));
    player.closeMiniMap();
    player.setBlockedMovement(false);
    notifyListeners();
  }

  void rollbackPlayerPosition(int moves){
    player.rollbackMoves(moves);
    notifyListeners();
  }

  void setBlockMovement(bool blockMovement) {
    if(player.getBlockedMovement() != blockMovement){
      player.setBlockedMovement(blockMovement);
      notifyListeners();
    }
  }

  bool getBlockedMovement() {
    return player.getBlockedMovement();
  }

  String getPlayerPositionId() {
    return player.getPlayerPositionId();
  }

  EquipmentState getPlayerEquipment() {
    return player.getPlayerEquipment();
  }

  void setAllowedMoves(AllowedMoves allowedMoves) {
    player.allowedMoves = allowedMoves;
    notifyListeners();
  }

  AllowedMoves getAllowedMoves() {
    return player.getAllowedMoves();
  }

  SpecialWidget? getOpenedSpecialWidget() {
    return player.getOpenedSpecialWidget();
  }

  bool getEquipmentOpen() {
     return player.getEquipmentOpen();
  }

  void openEquipment() {
    player.openEquipment();
  }

  void closeEquipment() {
    player.closeEquipment();
  }

  bool getMinimapOpen(){
    return player.getMinimapOpen();
  }

  void openMiniMap() {
    player.setBlockedMovement(true);
    player.openMiniMap();
  }

  void closeMiniMap() {
    player.setBlockedMovement(false);
    player.closeMiniMap();
  }

}
