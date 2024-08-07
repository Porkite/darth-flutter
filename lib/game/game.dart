import 'package:darth_flutter/game/paragraph-view-factory.dart';
import 'package:darth_flutter/service/model/allowedMoves.dart';
import 'package:flutter/material.dart';

import '../player/player-appbar-stats-widget.dart';
import '../player/player.dart';
import 'package:provider/provider.dart';
import '../service/game_manager.dart';

import '../service/model/direction.dart';
import 'equipment.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  String playerPositionId = 'b2';
  Player player = Player();

  void setNewPositionByDirection(Direction direction) {
    setState(() {
      GameManager().changePlayerPosition(direction);
      playerPositionId = GameManager().getPlayerPositionId();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildDirectionButton({
    required IconData icon,
    required bool isAllowed,
    required Direction direction,
  }) {
    return FloatingActionButton(
      onPressed: isAllowed
          ? () => GameManager().changePlayerPosition(direction)
          : null,
      backgroundColor: isAllowed ? null : Colors.grey,
      heroTag: direction.toString(),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        flexibleSpace: Row(
          children: [
            PlayerAppBarStatsWidget(),
          ],
        ),
        title: Selector<GameManager, String>(
          selector: (_, gm) => gm.getPlayerPositionId(),
          builder: (_, positionId, __) => Text(
            'Ekran przygody ($positionId)',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Selector<GameManager, String>(
          selector: (_, gm) => gm.getPlayerPositionId(),
          builder: (context, positionId, __) {
            return FutureBuilder<Widget>(
              future: ParagraphViewFactory.buildParagraphViewByIdentifier(
                  positionId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Wystąpił błąd: ${snapshot.error}');
                } else {
                  return snapshot.data ?? Container();
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: Selector<GameManager, AllowedMoves>(
        selector: (_, gm) => gm.getAllowedMoves(),
        builder: (_, allowedMoves, __) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildDirectionButton(
                    icon: Icons.arrow_circle_up,
                    isAllowed: allowedMoves.north,
                    direction: Direction.NORTH,
                  ),
                ),
                const SizedBox(width: 64),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: EquipmentButton.getEquipmentButton(setState)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildDirectionButton(
                    icon: Icons.arrow_circle_left,
                    isAllowed: allowedMoves.east,
                    direction: Direction.EAST,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildDirectionButton(
                    icon: Icons.arrow_circle_down,
                    isAllowed: allowedMoves.south,
                    direction: Direction.SOUTH,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildDirectionButton(
                    icon: Icons.arrow_circle_right,
                    isAllowed: allowedMoves.west,
                    direction: Direction.WEST,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
