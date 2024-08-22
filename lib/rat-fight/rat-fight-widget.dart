import 'package:flutter/material.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';
import 'dart:async';
import 'dart:math';

import 'guest-pinter.dart';

class RatFightWidget extends StatefulWidget {
  const RatFightWidget({super.key});

  @override
  _RatFightWidgetState createState() => _RatFightWidgetState();
}

class _RatFightWidgetState extends State<RatFightWidget> {
  Timer? _timer;
  double _leftPosition = 0;
  double _topPosition = 0;
  bool _initialized = false;
  bool _showDamage = false;
  int _damageScore = 0;
  Offset? _damagePosition;
  int fighterSize = 100;
  int health = 100;
  bool _swipeDetected = false;
  final List<Offset> _swipePath = [];

  @override
  void initState() {
    super.initState();
    _startMovingEnemy();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _moveToRandomPosition();
      _initialized = true;
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
      setState(() {
        _moveToRandomPosition();
        _setNextMove();
      });
    });
  }

  void _moveToRandomPosition() {
    Random random = Random();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double maxY = screenHeight * 2 / 3;
    double minY = screenHeight * 1 / 8;

    _leftPosition = random.nextDouble() * (screenWidth - 150);
    _topPosition = minY + random.nextDouble() * (maxY - minY - 50);
  }

  double _calculateScale(double topPosition, double screenHeight) {
    double minY = screenHeight * 1 / 8;
    double maxY = screenHeight * 1 / 2;
    double normalizedTop = (topPosition - minY) / (maxY - minY);
    return 1.0 / 3.0 + normalizedTop * (1.0 - 1.0 / 3.0);
  }

  void _handleSwipe() {
    setState(() {
      _showDamage = true;
      _damageScore = 5;
      _damagePosition = Offset(_leftPosition, _topPosition);
      health = max(0, health - 5);
      _swipeDetected = true;
    });
    Timer(Duration(seconds: 1), () {
      setState(() {
        _showDamage = false;
      });
    });
  }

  void _handleGesture(List<Offset> points) {
    RecognizedUnistroke? recognizedUnistroke = recognizeUnistroke(points);
    if (recognizedUnistroke != null){
      print('Detected shape: ${recognizedUnistroke.name} with score ${recognizedUnistroke.score.toStringAsFixed(2)}');
      if (recognizedUnistroke.name == DefaultUnistrokeNames.circle) {
        setState(() {
          _showDamage = true;
          _damageScore = 10;
          _damagePosition = Offset(_leftPosition, _topPosition);
          health = max(0, health - 10);
          _swipeDetected = true;
        });
        Timer(Duration(seconds: 1), () {
          setState(() {
            _showDamage = false;
          });
        });
      } else if (recognizedUnistroke.name == DefaultUnistrokeNames.triangle) {
        setState(() {
          _showDamage = true;
          _damageScore = 20;
          _damagePosition = Offset(_leftPosition, _topPosition);
          health = max(0, health - 20);
          _swipeDetected = true;
        });
        Timer(Duration(seconds: 1), () {
          setState(() {
            _showDamage = false;
          });
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double scale = _calculateScale(_topPosition, screenHeight);

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _swipePath.add(details.localPosition);
        });
        if (!_swipeDetected && _isSwipeIntersecting(details.localPosition)) {
          _handleSwipe();
        }
      },
      onPanEnd: (details) {
        _handleGesture(_swipePath);
        _swipeDetected = false;
        setState(() {
          _swipePath.clear();
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rat-fighter/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 125, // Adjust the position as needed
            child: Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown, width: 3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  colors: const [Colors.red, Colors.green],
                  stops: [health / 100, health / 100],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.brown, width: 3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showDamage && _damagePosition != null)
            Positioned(
              top: _damagePosition!.dy - 40 + 30 / scale,
              left: _damagePosition!.dx + 75 * scale,
              child: Text(
                '-$_damageScore HP',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _topPosition,
            left: _leftPosition,
            child: AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/images/rat-fighter/rat.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 2 - 250,
            child: Image.asset(
              'assets/images/rat-fighter/player.png',
              width: 500,
              height: 500,
              fit: BoxFit.fill,
            ),
          ),
          if (_swipePath.isNotEmpty)
            CustomPaint(
              painter: GuestPointer(_swipePath),
            ),
        ],
      ),
    );
  }

  bool _isSwipeIntersecting(Offset position) {
    return position.dx >= _leftPosition &&
        position.dx <= _leftPosition + 150 &&
        position.dy >= _topPosition &&
        position.dy <= _topPosition + 150;
  }

}


