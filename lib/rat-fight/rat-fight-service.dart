import 'dart:async';
import 'dart:math';
import 'package:darth_flutter/rat-fight/paragraph-widgets/rat-fight-state.dart';
import 'package:flutter/material.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';

class RatFightService with ChangeNotifier {
  Timer? _timer;
  Timer? _attackTimer;
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
  final StreamController<void> _blockGestureController = StreamController<void>.broadcast();
  late double scale;
  Stream<void> get  _blockGestureStream => _blockGestureController.stream;

  double get leftPosition => _leftPosition;

  double get topPosition => _topPosition;

  bool get showGivenDamage => _showGivenDamage;

  int get givenDamageScore => _givenDamageScore;

  int get getEnemyHealth => enemyHealth;

  List<Offset> get swipePath => List.unmodifiable(_swipePath);

  bool get isSwipeDetected => _swipeDetected;

  bool get isFlashing => _isFlashing;

  void initialize(BuildContext context) {
    if (!_initialized) {
      _context = context;
      _moveToRandomPosition();
      _initialized = true;
      _startMovingEnemy();
      _startAttackTimer();
      double screenHeight = MediaQuery.of(_context).size.height;
      scale = calculateScale(screenHeight);
    }
  }

  void _startMovingEnemy() {
    _setNextMove();
  }

  void _startAttackTimer() {
    _attackTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _triggerFlashing();
      _startBlockTimer();
    });
  }

  void _startBlockTimer() {
    bool isBlocked = false;
    _blockGestureStream.listen((_) {
      isBlocked = true;
    });

    Timer(const Duration(seconds: _timeForBlock), () {
      if (!isBlocked) {
        playerHealth -= 15;
        if(playerHealth <= 0){
          loseGame(_context);
        }
        notifyListeners();
      }
      isBlocked = false;
    });
  }

  void _triggerFlashing() {
    _isFlashing = true;
    notifyListeners();

    Timer(const Duration(seconds: _timeForBlock), () {
      _isFlashing = false;
      notifyListeners();
    });
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
      _applyDamage(5);
    }
  }

  void handleGesture(
      List<Offset> points, RecognizedUnistroke? recognizedUnistroke) {
    if (recognizedUnistroke != null) {
      if (recognizedUnistroke.name == DefaultUnistrokeNames.circle) {
        _blockGestureController.add(null);
      } else if (recognizedUnistroke.name == DefaultUnistrokeNames.triangle) {
        _applyDamage(20);
      }
    }
  }

  void _applyDamage(int damage) {
    enemyHealth = max(0, enemyHealth - damage);
    if(enemyHealth <= 0){
      winGame(_context);
    }
    _swipeDetected = true;
    notifyListeners();
    _givenDamageScore = damage;
    _showGivenDamage = true;
    Timer(Duration(seconds: 1), () {
      _showGivenDamage = false;
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

  void winGame(BuildContext context) {
    Navigator.pop(context, RatFightState.WIN);
  }

  void loseGame(BuildContext context) {
    Navigator.pop(context, RatFightState.LOSE);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blockGestureController.close();
    super.dispose();
  }
}
