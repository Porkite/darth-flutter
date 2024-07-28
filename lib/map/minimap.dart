import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../service/game_manager.dart';
import 'map-cell.dart';
import 'minimap-service.dart';

class MinimapWidget extends StatefulWidget {
  const MinimapWidget({super.key});

  @override
  _MinimapWidgetState createState() => _MinimapWidgetState();
}

class _MinimapWidgetState extends State<MinimapWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final minimapService = Provider.of<MinimapService>(context);
    final playerPositionId = GameManager().getPlayerPositionId();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/minimap/minimap-bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: minimapService.maxX - minimapService.minX + 1,
        ),
        itemCount: (minimapService.maxX - minimapService.minX + 1) *
            (minimapService.maxY - minimapService.minY + 1),
        itemBuilder: (context, index) {
          int row = index ~/ (minimapService.maxX - minimapService.minX + 1) +
              minimapService.minY;
          int col = index % (minimapService.maxX - minimapService.minX + 1) +
              minimapService.minX;

          MapCell? cell = minimapService.mapCells.firstWhereOrNull(
            (element) => element.xPos == col && element.yPos == row,
          );

          if (cell == null) {
            return const SizedBox.shrink();
          }

          Color borderColor =
              cell.key == playerPositionId ? Colors.green : Colors.black;
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(cell.description),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                              child: Text(
                                  'Uber w to miejsce bedzie cię kosztować 30 monet'),
                            ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  minimapService.teleportToId(cell.key);
                                },
                                child: const Text('Wieź mnie!'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                double imageSize = constraints.maxWidth * 0.4;
                double fontSize = constraints.maxWidth * 0.15;
                double imageBottomMargin = constraints.maxWidth * 0.01;
                double cellMargin = constraints.maxWidth * 0.08;
                return Container(
                  margin: EdgeInsets.all(cellMargin),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    color: Colors.blueGrey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: cell.key == playerPositionId
                            ? Colors.green.withOpacity(1)
                            : Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 15,
                        offset: const Offset(2, 2),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (cell.npcImg != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: imageBottomMargin),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(cell.npcImg ?? ''),
                            radius: imageSize / 2,
                          ),
                        ),
                      Text(
                        cell.key,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
