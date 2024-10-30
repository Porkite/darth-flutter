import 'package:flutter/foundation.dart';

class Player extends ChangeNotifier {
  static final Player _instance = Player._internal();
  late String _avatarUrl;
  late int _hp;
  late int _coins;

  factory Player() => _instance;

  Player._internal() {
    _avatarUrl = 'assets/images/player_avatar.png';
    _hp = 100;
    _coins = 137;
  }

  String get avatarUrl => _avatarUrl;

  int get hp => _hp;

  int get coins => _coins;

  void addCoins(int coins) {
    this._coins += coins;
    notifyListeners();
  }

  void clearCoins() {
    this._coins = 0;
    notifyListeners();
  }

  void subtractCoins(int coins) {
    int newValue = this._coins - coins;

    if (this._coins > 0 && newValue >= 0) {
      this._coins = newValue;
    } else {
      throw 'Jesteś zbyt biedny, aby pozwolić sobie na ten luksus!';
    }
    notifyListeners();
  }

  void addHp(int hp) {
    this._hp = (_hp + hp).clamp(0, 100);
    notifyListeners();
  }

}
