import 'package:darth_flutter/rat-fight/game-widgets/rat-fight-widget.dart';
import 'package:darth_flutter/rat-fight/paragraph-data.dart';
import 'package:darth_flutter/service/game_manager.dart';
import 'package:flutter/material.dart';

import '../../player/player.dart';
import '../rat-fight-state.dart';

class EntryWidget extends StatelessWidget {
  final Function(RatFightState) onUpdateRatFightState;
  final ParagraphData paragraphData;

  const EntryWidget({Key? key, required this.paragraphData, required this.onUpdateRatFightState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
           Text(
            paragraphData.entryText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _takeChickenDecision(context);
            },
            child: Text(paragraphData.entryChickenText),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RatFightWidget(),
                ),
              ).then((result) {
                if (result != null && result is RatFightState) {
                  onUpdateRatFightState(result);
                }
              });
            },
            child: Text(paragraphData.entryFightButton),
          ),
        ],
      ),
    );
  }

  void _takeChickenDecision(BuildContext context) {
    try {
      Player().subtractCoins(20);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(paragraphData.entryGivenMoneyText),
            actions: [
              TextButton(
                onPressed: () {
                  GameManager().rollbackPlayerPosition(1);
                  Navigator.pop(context);
                },
                child: Text(paragraphData.entryOkText),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(paragraphData.entryNoMoneyText),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RatFightWidget(),
                    ),
                  ).then((result) {
                    if (result != null && result is RatFightState) {
                      onUpdateRatFightState(result);
                    }
                  });
                },
                child: Text(paragraphData.entryDanceText),
              ),
            ],
          );
        },
      );
    }
  }
}
