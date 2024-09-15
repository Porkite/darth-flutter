import 'package:darth_flutter/rat-fight/game-widgets/rat-fight-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';
import '../../service/model/equipment_state.dart';
import 'guest-pinter.dart';

class RatFightWidget extends StatelessWidget {
  const RatFightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<RatFightService>(
      create: (_) => RatFightService(),
      child: Consumer<RatFightService>(
        builder: (context, ratFightService, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ratFightService.initialize(context);
          });
          double scale = ratFightService.calculateScale(screenHeight);
          return GestureDetector(
            onPanUpdate: (details) => _handlePanUpdate(details, ratFightService),
            onPanEnd: (details) => _handlePanEnd(details, ratFightService),
            child: Stack(
              children: [
                _buildBackgroundImage(),
                _buildAnimatedRat(ratFightService, scale),
                _buildPlayerImage(screenWidth),
                _buildBloodOverlay(ratFightService),
                _buildEnemyHealthBar(ratFightService, screenWidth),
                _buildEquipmentList(ratFightService),
                if (ratFightService.swipePath.isNotEmpty)
                  CustomPaint(
                    painter: GuestPointer(ratFightService.swipePath),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/rat-fighter/background.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAnimatedRat(RatFightService ratFightService, double scale) {
    return AnimatedPositioned(
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
                style: _damageTextStyle(),
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
    );
  }

  Widget _buildPlayerImage(double screenWidth) {
    return Positioned(
      bottom: 0,
      left: (screenWidth - 300) / 2,
      child: Image.asset(
        'assets/images/rat-fighter/player.png',
        width: 300,
        height: 300,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildBloodOverlay(RatFightService ratFightService) {
    return Opacity(
      opacity: (1.0 - ratFightService.playerHealth / 100).clamp(0.0, 1.0),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rat-fighter/blood_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildEnemyHealthBar(RatFightService ratFightService, double screenWidth) {
    return Positioned(
      top: 20,
      left: screenWidth / 2 - 125,
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ratFightService.isFlashing ? Colors.yellow : Colors.brown,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEquipmentList(RatFightService ratFightService) {
    return Positioned(
      left: 0,
      top: 20,
      bottom: 20,
      child: SizedBox(
        width: 50,
        child: ListView.builder(
          itemCount: ratFightService.eqItems.length,
          itemBuilder: (context, index) {
            String key = ratFightService.eqItems.keys.elementAt(index);
            Item item = ratFightService.eqItems[key]!;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: IconButton(
                icon: Image.asset(
                  item.iconPath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  ratFightService.useEqItem(key);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _handlePanUpdate(DragUpdateDetails details, RatFightService ratFightService) {
    ratFightService.addSwipePath(details.localPosition);
    if (!ratFightService.isSwipeDetected) {
      ratFightService.handleSwipe(details.localPosition);
    }
  }

  void _handlePanEnd(DragEndDetails details, RatFightService ratFightService) {
    RecognizedUnistroke? recognizedUnistroke =
    recognizeUnistroke(ratFightService.swipePath);
    ratFightService.handleGesture(recognizedUnistroke);
    ratFightService.clearSwipePath();
  }

  TextStyle _damageTextStyle() {
    return const TextStyle(
      color: Colors.red,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }
}
