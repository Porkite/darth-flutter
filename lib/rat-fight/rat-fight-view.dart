import 'package:darth_flutter/rat-fight/paragraph-data.dart';
import 'package:darth_flutter/rat-fight/paragraph-widgets/entry-widget.dart';
import 'package:darth_flutter/rat-fight/paragraph-widgets/lose-widget.dart';
import 'package:darth_flutter/rat-fight/rat-fight-state.dart';
import 'package:darth_flutter/rat-fight/paragraph-widgets/win-widget.dart';
import 'package:flutter/material.dart';

import '../player/player.dart';
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
  late ParagraphData _paragraphData;

  @override
  void initState() {
    _paragraphData = ParagraphData.fromParagraph(widget.paragraph);
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

  void updateRatFightState(RatFightState newState) {
    if(newState == RatFightState.WIN) {
      GameManager().setBlockMovement(false);
    } else if (newState == RatFightState.LOSE) {
      Player().clearCoins();
    }
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
            backgroundImage: AssetImage(_paragraphData.npcImg),
            radius: 40,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.paragraph.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        if(_ratFightState == RatFightState.ENTRY)
          EntryWidget(paragraphData: _paragraphData, onUpdateRatFightState: updateRatFightState),
        if(_ratFightState == RatFightState.WIN)
          WinWidget(paragraphData: _paragraphData),
        if(_ratFightState == RatFightState.LOSE)
          LoseWidget(paragraphData: _paragraphData)
      ],
    );
  }
}
