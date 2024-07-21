import 'dart:core';

import 'package:darth_flutter/map/map-cell.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class MinimapWidget extends StatefulWidget {
  final List<String> paragraphIdentifiers;

  MinimapWidget({super.key, required this.paragraphIdentifiers});

  @override
  _MinimapWidgetState createState() => _MinimapWidgetState();
}

class _MinimapWidgetState extends State<MinimapWidget> {
  late final List<MapCell> mapCells;
  late final int maxX;
  late final int maxY;

  final String fileNamesInSequence = "abcdef";
  final String rankNamesInSequence = "1234";

  @override
  void initState() {
    var mappedRes = mapToCells(widget.paragraphIdentifiers);
    this.mapCells = mappedRes.item1;
    this.maxX = mappedRes.item2;
    this.maxY = mappedRes.item3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: maxX,
      ),
      itemCount: maxX * maxY,
      itemBuilder: (context, index) {
        int row = index ~/ maxX +1;
        int col = index % maxX +1;

        String cellId = mapCells
            .firstWhere((element) => element.xPos == col && element.yPos == row,
                orElse: () => MapCell(xPos: col, yPos: row, key: "N/A"))
            .key;

        return Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: cellId != "N/A" ? Colors.green : Colors.white,
          ),
          child: Center(child: Text(cellId)),
        );
      },
    );
  }
}


int countRows(List<String> identifiers) {
  final Set<String> uniqueLetters = {};
  for (var id in identifiers) {
    if (id.isNotEmpty) {
      uniqueLetters.add(id[1]);
    }
  }

  return uniqueLetters.length;
}

int countColumns(List<String> identifiers) {
  int maxNumber = 0;
  for (var id in identifiers) {
    String numberPart = id.substring(1);
    if (numberPart.isNotEmpty) {
      int number = int.parse(numberPart);
      if (number > maxNumber) {
        maxNumber = number;
      }
    }
  }
  return maxNumber;
}

Tuple3<List<MapCell>, int, int> mapToCells(List<String> identifiers) {
  List<MapCell> map = [];
  int maxX = 0;
  int maxY = 0;
  for (var i in identifiers){
    var decodedX = i.codeUnitAt(0)-96;
    var decodedY = int.parse(i.substring(1));
    maxX = decodedX > maxX ? decodedX : maxX;
    maxY = decodedY > maxY ? decodedY : maxX;
    map.add(MapCell(xPos: decodedX , yPos: decodedY, key: i));
  }
  return Tuple3(map, maxX+1, maxY);
}