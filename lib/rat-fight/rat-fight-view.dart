import 'package:darth_flutter/rat-fight/paragraph-widgets/entry-widget.dart';
import 'package:darth_flutter/rat-fight/paragraph-widgets/lose-widget.dart';
import 'package:darth_flutter/rat-fight/paragraph-widgets/rat-fight-state.dart';
import 'package:darth_flutter/rat-fight/paragraph-widgets/win-widget.dart';
import 'package:flutter/material.dart';

import '../service/game_manager.dart';
import '../service/model/adventure_models.dart';

class RatFightViewWidget extends StatefulWidget {
  final Paragraph paragraph;

  const RatFightViewWidget({super.key, required this.paragraph});

  @override
  State<RatFightViewWidget> createState() => _RatFightViewWidget();
}

class _RatFightViewWidget extends State<RatFightViewWidget> {
  late RatFightState _ratFightState;

  @override
  void initState() {
    super.initState();
    _ratFightState = RatFightState.ENTRY;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      GameManager().setBlockMovement(true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GameManager().setBlockMovement(false);
    });
    super.dispose();
  }

  // Funkcja do aktualizacji stanu ratFightState
  void updateRatFightState(RatFightState newState) {
    setState(() {
      _ratFightState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/rat-fighter/rat.png"),
            radius: 40,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Ojj zły kanał bratku",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        if(_ratFightState == RatFightState.ENTRY)
          EntryWidget(onUpdateRatFightState: updateRatFightState),
        if(_ratFightState == RatFightState.WIN)
          WinWidget(),
        if(_ratFightState == RatFightState.LOSE)
          LoseWidget()
      ],
    );
  }
}
