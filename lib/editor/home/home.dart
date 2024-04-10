import 'package:darth_flutter/editor/editor-manager.dart';
import 'package:darth_flutter/editor/home/paragraph-properties.dart';
import 'package:flutter/material.dart';

import '../file-manager.dart';
import 'adventure-settings.dart';
import 'map-presenter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: EditorManager().adventureDataAsJson);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveFile() async {
    FileManager().saveFile(_controller.text);
  }

  void _selectParagraph(String id) async {
    // EditorManager().selectedParagraphId = id;
    // print('Paragraph selected:' + EditorManager().selectedParagraphId);
    setState(() {
      EditorManager().selectedParagraphId = id;
      print('Paragraph selected:' + EditorManager().selectedParagraphId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edytor Przygody'),
      ),
      drawer: AdventureSettingsDrawer(
        onSave: () {
          _saveFile();
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: MapPresenter(
                  onParagraphClick: (id) {
                    _selectParagraph(id);
                  },
                ),
              ),
            ),
            Expanded(child: ParagraphProperties())
          ],
        ),
      ),
    );
  }
}
