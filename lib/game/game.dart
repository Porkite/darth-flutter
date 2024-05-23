import 'package:darth_flutter/game/paragraph-view-factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/game_manager.dart';
import 'controls/floating-action-button.dart';
import '../service/model/direction.dart';
import 'equipment.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildDirectionButton({
    required IconData icon,
    required bool isBlocked,
    required Direction direction,
  }) {
    return FloatingActionButton(
      onPressed: isBlocked
          ? null
          : () => GameManager().changePlayerPosition(direction),
      backgroundColor: isBlocked ? Colors.grey : null,
      heroTag: direction.toString(),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Selector<GameManager, String>(
          selector: (_, gm) => gm.getPlayerPositionId(),
          builder: (_, positionId, __) => Text(
            'Ekran przygody ($positionId)',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
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
      floatingActionButton: Selector<GameManager, bool>(
        selector: (_, gm) => gm.getBlockedMovement(),
        builder: (_, isBlocked, __) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DarthFloatingActionButton(
                    onPressed: () {
                      setNewPositionByDirection(Direction.NORTH);
                    },
                    child: Icon(Icons.arrow_circle_up),
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
                    isBlocked: isBlocked,
                    direction: Direction.EAST,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildDirectionButton(
                    icon: Icons.arrow_circle_down,
                    isBlocked: isBlocked,
                    direction: Direction.SOUTH,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildDirectionButton(
                    icon: Icons.arrow_circle_right,
                    isBlocked: isBlocked,
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
