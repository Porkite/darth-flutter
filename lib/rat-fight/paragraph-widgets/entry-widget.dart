import 'package:darth_flutter/rat-fight/rat-fight-widget.dart';
import 'package:darth_flutter/service/game_manager.dart';
import 'package:flutter/material.dart';

import '../../player/player.dart';
import 'rat-fight-state.dart'; // Import enum

class EntryWidget extends StatelessWidget {
  // Funkcja callback do aktualizacji stanu w nadrzędnym widgetcie
  final Function(RatFightState) onUpdateRatFightState;

  const EntryWidget({Key? key, required this.onUpdateRatFightState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          const Text(
            "Tej siwowąsy wyskakuj z talarków albo zgasze na tobie peta!!!",
            textAlign: TextAlign.center,
            style: TextStyle(
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
            child: Text('Dobrze proszę Pana'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Nawigacja do `RatFightWidget`
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RatFightWidget(), // Prawidłowa nawigacja
                ),
              ).then((result) {
                if (result != null && result is RatFightState) {
                  // Wywołanie callbacka z odpowiednim wynikiem
                  onUpdateRatFightState(result);
                }
              });
            },
            child: Text('Posmakuj srebra na ostrzu'),
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
            content: Text('Oddałeś 20 sztuk złota'),
            actions: [
              TextButton(
                onPressed: () {
                  GameManager().rollbackPlayerPosition(1);
                  // Wywołanie callbacka po sukcesie
                  onUpdateRatFightState(RatFightState.WIN);
                  Navigator.pop(context);
                },
                child: Text('OK'),
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
            content: Text('Nie masz tyle biedaku. \n Zatańczmy!!!'),
            actions: [
              TextButton(
                onPressed: () {
                  // Przechodzimy do walki
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
                child: Text('Nie umiem tańczyć'),
              ),
            ],
          );
        },
      );
    }
  }
}
