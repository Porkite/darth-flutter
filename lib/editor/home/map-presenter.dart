import 'package:flutter/material.dart';

import '../../service/model/adventure_models.dart';
import '../editor-manager.dart';

class MapPresenter extends StatefulWidget {
  final Function(String) onParagraphClick;

  const MapPresenter({super.key, required this.onParagraphClick});

  @override
  State<MapPresenter> createState() => _MapPresenterState();
}

class _MapPresenterState extends State<MapPresenter> {
  final AdventureData data = EditorManager().adventureData;

  getParagraphIndex() {
    return data.mapData.mapRows;
  }

  getParagraphGridColor(id) {
    Paragraph paragraph = EditorManager().getParagraph(id);
    if (paragraph.text != '' || paragraph.options.isNotEmpty) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> flattenedMatrix = [];
    for (int i = 0; i < data.mapData.rankNamesInSequence.length; i++) {
      for (int j = 0; j < data.mapData.fileNamesInSequence.length; j++) {
        flattenedMatrix.add(data.mapData.fileNamesInSequence[j] +
            data.mapData.rankNamesInSequence[i]);
      }
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reprezentacja Mapy'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: data.mapData.fileNamesInSequence.length,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: flattenedMatrix.length,
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    widget.onParagraphClick(flattenedMatrix[index]);
                  },
                  child: Container(
                    color: getParagraphGridColor(flattenedMatrix[index]),
                    child: Center(
                      child: Text(
                        flattenedMatrix[index],
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
