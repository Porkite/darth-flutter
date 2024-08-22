import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';

class RatFightService with ChangeNotifier {
  Timer? _timer;
  double _leftPosition = 0;
  double _topPosition = 0;
  bool _showDamage = false;
  int _damageScore = 0;
  Offset? _damagePosition;
  int fighterSize = 100;
  int health = 100;
  bool _swipeDetected = false;
  final List<Offset> _swipePath = [];
  bool _initialized = false;
  late BuildContext _context;


  double get leftPosition => _leftPosition;
  double get topPosition => _topPosition;
  bool get showDamage => _showDamage;
  int get damageScore => _damageScore;
  Offset? get damagePosition => _damagePosition;
  int get playerHealth => health;
  List<Offset> get swipePath => List.unmodifiable(_swipePath);
  bool get isSwipeDetected => _swipeDetected;

  void initialize(BuildContext context) {
    if (!_initialized) {
      _context = context;
      _moveToRandomPosition();
      _initialized = true;
      _startMovingEnemy();
    }
  }

  void _startMovingEnemy() {
    _setNextMove();
  }

  void _setNextMove() {
    Random random = Random();
    int randomTime = 500 + random.nextInt(1500);
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: randomTime), () {
      _moveToRandomPosition();
      _setNextMove();
    });
  }

  void _moveToRandomPosition() {
    Random random = Random();
    double screenWidth = MediaQuery.of(_context).size.width;
    double screenHeight = MediaQuery.of(_context).size.height;

    double maxY = screenHeight * 2 / 3;
    double minY = screenHeight * 1 / 8;

    _leftPosition = random.nextDouble() * (screenWidth - 150);
    _topPosition = minY + random.nextDouble() * (maxY - minY - 50);
    notifyListeners();
  }

  double calculateScale(double screenHeight) {
    double minY = screenHeight * 1 / 8;
    double maxY = screenHeight * 1 / 2;
    double normalizedTop = (_topPosition - minY) / (maxY - minY);
    return 1.0 / 3.0 + normalizedTop * (1.0 - 1.0 / 3.0);
  }

  void handleSwipe(Offset position) {
    if (_isSwipeIntersecting(position)) {
      _showDamage = true;
      _damageScore = 5;
      _damagePosition = Offset(_leftPosition, _topPosition);
      health = max(0, health - 5);
      _swipeDetected = true;
      notifyListeners();

      Timer(Duration(seconds: 1), () {
        _showDamage = false;
        notifyListeners();
      });
    }
  }

  void handleGesture(List<Offset> points, RecognizedUnistroke? recognizedUnistroke) {
    if (recognizedUnistroke != null) {
      if (recognizedUnistroke.name == DefaultUnistrokeNames.circle) {
        _applyDamage(10);
      } else if (recognizedUnistroke.name == DefaultUnistrokeNames.triangle) {
        _applyDamage(20);
      }
    }
  }

  void _applyDamage(int damage) {
    _showDamage = true;
    _damageScore = damage;
    _damagePosition = Offset(_leftPosition, _topPosition);
    health = max(0, health - damage);
    _swipeDetected = true;
    notifyListeners();

    Timer(Duration(seconds: 1), () {
      _showDamage = false;
      notifyListeners();
    });
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
