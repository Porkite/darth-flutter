import 'package:darth_flutter/rat-fight/rat-fight-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';
import 'guest-pinter.dart';

class RatFightWidget extends StatelessWidget {
  const RatFightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ratFightService = Provider.of<RatFightService>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ratFightService.initialize(context);
    });

    double screenHeight = MediaQuery.of(context).size.height;
    double scale = ratFightService.calculateScale(screenHeight);

    return GestureDetector(
      onPanUpdate: (details) {
        ratFightService.addSwipePath(details.localPosition);
        if (!ratFightService.isSwipeDetected) {
          ratFightService.handleSwipe(details.localPosition);
        }
      },
      onPanEnd: (details) {
        RecognizedUnistroke? recognizedUnistroke =
            recognizeUnistroke(ratFightService.swipePath);
        ratFightService.handleGesture(
            ratFightService.swipePath, recognizedUnistroke);
        ratFightService.clearSwipePath();
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: ratFightService.topPosition,
            left: ratFightService.leftPosition,
            child: AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Stack(
                children: [
                  if (ratFightService.showGivenDamage)
                  Text(
                    '-${ratFightService.givenDamageScore} HP',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 180 * scale,
                        height: 180 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ratFightService.isFlashing
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/rat-fighter/rat.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: (MediaQuery.of(context).size.width - 300) / 2,
            child: Image.asset(
              'assets/images/rat-fighter/player.png',
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
          Opacity(
            opacity: (1.0 - ratFightService.playerHealth / 100).clamp(0.0, 1.0),
            child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rat-fighter/blood_screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          )),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 125,
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
                  stops: [
                    ratFightService.getEnemyHealth / 100,
                    ratFightService.getEnemyHealth / 100
                  ],
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),  // Czas trwania animacji
                      curve: Curves.easeInOut,  // Krzywa animacji
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ratFightService.isFlashing ? Colors.yellow : Colors.brown,  // Zmieniaj kolor na żółty gdy isFlashing = true
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (ratFightService.swipePath.isNotEmpty)
            CustomPaint(
              painter: GuestPointer(ratFightService.swipePath),
            ),
        ],
      ),
    );
  }
}
