import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';
import '../../service/game_manager.dart';
import '../../service/items_manager.dart';
import '../../service/model/equipment_state.dart';
import '../rat-fight-state.dart';

class RatFightService with ChangeNotifier {
  final List<Timer> _timers = [];
  double _leftPosition = 0;
  double _topPosition = 0;
  bool _showGivenDamage = false;
  int _givenDamageScore = 0;
  int fighterSize = 100;
  int enemyHealth = 100;
  int playerHealth = 100;
  static const int _timeForBlock = 2;
  bool _swipeDetected = false;
  bool _isFlashing = false;
  final List<Offset> _swipePath = [];
  bool _initialized = false;
  late BuildContext _context;
  late double scale;
  Map<String, Item> eqItems = {};
  final StreamController<void> _blockGestureController = StreamController<void>.broadcast();

  // Getters
  Stream<void> get blockGestureStream => _blockGestureController.stream;
  double get leftPosition => _leftPosition;
  double get topPosition => _topPosition;
  bool get showGivenDamage => _showGivenDamage;
  int get givenDamageScore => _givenDamageScore;
  int get getEnemyHealth => enemyHealth;
  List<Offset> get swipePath => List.unmodifiable(_swipePath);
  bool get isSwipeDetected => _swipeDetected;
  bool get isFlashing => _isFlashing;

  void initialize(BuildContext context) {
    if (_initialized) return;

    _context = context;
    _moveToRandomPosition();
    _initialized = true;
    _startMovingEnemy();
    _startAttackTimer();
    _initializeScale();
    eqItems = _loadEquipmentItems();
  }

  void _initializeScale() {
    final screenHeight = MediaQuery.of(_context).size.height;
    scale = calculateScale(screenHeight);
  }

  Map<String, Item> _loadEquipmentItems() {
    final playerEquipment = GameManager().getPlayerEquipment().getItems();
    return ItemsManager().getItemsAsItemsFromInventory(playerEquipment);
  }

  void _startMovingEnemy() {
    _setNextMove();
  }

  void _startAttackTimer() {
    final attackTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _triggerFlashing();
      _startBlockTimer();
    });
    _timers.add(attackTimer);
  }

  void _startBlockTimer() {
    bool isBlocked = false;
    blockGestureStream.listen((_) => isBlocked = true);

    final blockTimer = Timer(const Duration(seconds: _timeForBlock), () {
      if (!isBlocked) _applyPlayerDamage(15);
    });
    _timers.add(blockTimer);
  }

  void _applyPlayerDamage(int damage) {
    playerHealth = max(0, playerHealth - damage);
    if (playerHealth <= 0) loseGame();
    notifyListeners();
  }

  void _triggerFlashing() {
    _isFlashing = true;
    notifyListeners();

    final flashingTimer = Timer(const Duration(seconds: _timeForBlock), () {
      _isFlashing = false;
      notifyListeners();
    });
    _timers.add(flashingTimer);
  }

  void _setNextMove() {
    final randomTime = 500 + Random().nextInt(1500);
    final moveTimer = Timer(Duration(milliseconds: randomTime), () {
      _moveToRandomPosition();
      _setNextMove();
    });
    _timers.add(moveTimer);
  }

  void _moveToRandomPosition() {
    final screenWidth = MediaQuery.of(_context).size.width;
    final screenHeight = MediaQuery.of(_context).size.height;
    final maxY = screenHeight * 2 / 3;
    final minY = screenHeight * 1 / 8;

    _leftPosition = Random().nextDouble() * (screenWidth - 150);
    _topPosition = minY + Random().nextDouble() * (maxY - minY - 50);
    notifyListeners();
  }

  double calculateScale(double screenHeight) {
    final minY = screenHeight * 1 / 8;
    final maxY = screenHeight * 1 / 2;
    final normalizedTop = (_topPosition - minY) / (maxY - minY);
    return 1.0 / 3.0 + normalizedTop * (1.0 - 1.0 / 3.0);
  }

  void handleSwipe(Offset position) {
    if (_isSwipeIntersecting(position)) {
      _applyDamage(5);
    }
  }

  void handleGesture(RecognizedUnistroke? recognizedUnistroke) {
    if (recognizedUnistroke == null) return;

    switch (recognizedUnistroke.name) {
      case DefaultUnistrokeNames.circle:
        _blockGestureController.add(null);
        break;
      case DefaultUnistrokeNames.triangle:
        _applyDamage(20);
        break;
      default:
        break;
    }
  }

  void _applyDamage(int damage) {
    enemyHealth = max(0, enemyHealth - damage);
    if (enemyHealth <= 0) winGame();
    _showGivenDamageAnimation(damage);
  }

  void _showGivenDamageAnimation(int damage) {
    _swipeDetected = true;
    _givenDamageScore = damage;
    _showGivenDamage = true;
    notifyListeners();

    final damageTimer = Timer(const Duration(seconds: 1), () {
      _showGivenDamage = false;
      notifyListeners();
    });
    _timers.add(damageTimer);
  }

  void addSwipePath(Offset position) {
    _swipePath.add(position);
    notifyListeners();
  }

  void clearSwipePath() {
    _swipePath.clear();
    _swipeDetected = false;
    notifyListeners();
  }

  bool _isSwipeIntersecting(Offset position) {
    return position.dx >= _leftPosition &&
        position.dx <= _leftPosition + 150 &&
        position.dy >= _topPosition &&
        position.dy <= _topPosition + 150;
  }

  void winGame() {
    Navigator.pop(_context, RatFightState.WIN);
  }

  void useEqItem(String itemIdentifier) {
    GameManager().getPlayerEquipment().removeItem(itemIdentifier);
    eqItems = _loadEquipmentItems();
    playerHealth += 50;
  }

  void loseGame() {
    Navigator.pop(_context, RatFightState.LOSE);
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    _blockGestureController.close();
    super.dispose();
  }
}
