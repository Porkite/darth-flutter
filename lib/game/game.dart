import 'package:darth_flutter/game/paragraph-view-factory.dart';
import 'package:darth_flutter/service/model/allowedMoves.dart';
import 'package:darth_flutter/service/model/special-widget.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../player/player-appbar-stats-widget.dart';
import '../player/player.dart';
import 'package:provider/provider.dart';
import '../service/game_manager.dart';

import '../service/model/direction.dart';
import 'controls/floating-action-button.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Selector<GameManager, String>(
          selector: (_, gm) => gm.getPlayerPositionId(),
          builder: (context, positionId, __) {
            return FutureBuilder<Widget>(
              future: ParagraphViewFactory.buildParagraphViewByIdentifier(context,
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
      floatingActionButton:
          Selector<GameManager, Tuple3<AllowedMoves, bool, SpecialWidget?>>(
        selector: (_, gm) => Tuple3(gm.getAllowedMoves(),
            gm.getBlockedMovement(), gm.getOpenedSpecialWidget()),
        builder: (_, navigationConf, __) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (!navigationConf.item2)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildDirectionButton(
                      icon: Icons.arrow_circle_up,
                      isAllowed: navigationConf.item1.north,
                      direction: Direction.NORTH,
                    ),
                  ),
                  const SizedBox(width: 64),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(padding: EdgeInsets.only(left: 30)),
                if (navigationConf.item3 != SpecialWidget.minimap)
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: EquipmentButton.getEquipmentButton(setState)),
                if (navigationConf.item3 != SpecialWidget.equipment)
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: MinimapButton.getMinimapButton(setState)),
                const Spacer(),
                if (!navigationConf.item2)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildDirectionButton(
                      icon: Icons.arrow_circle_left,
                      isAllowed: navigationConf.item1.east,
                      direction: Direction.EAST,
                    ),
                  ),
                if (!navigationConf.item2)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildDirectionButton(
                      icon: Icons.arrow_circle_down,
                      isAllowed: navigationConf.item1.south,
                      direction: Direction.SOUTH,
                    ),
                  ),
                if (!navigationConf.item2)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildDirectionButton(
                      icon: Icons.arrow_circle_right,
                      isAllowed: navigationConf.item1.west,
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

class MinimapButton {
  static Widget getMinimapButton(Function setState) {
    var closeButton = DarthFloatingActionButton(
      onPressed: () {
        setState(() {
          GameManager().closeMiniMap();
        });
      },
      child: const Icon(Icons.zoom_in_map),
    );

    var openButton = DarthFloatingActionButton(
      onPressed: () {
        setState(() {
          GameManager().openMiniMap();
        });
      },
      child: const Icon(Icons.map),
    );

    return GameManager().getMinimapOpen() ? closeButton : openButton;
  }
}
