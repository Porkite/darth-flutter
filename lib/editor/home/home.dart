import 'package:darth_flutter/editor/editor-manager.dart';
import 'package:flutter/material.dart';

import '../file-manager.dart';
import 'adventure-settings.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adventure Editor'),
      ),
      drawer: AdventureSettingsDrawer(
        onSave: () {
          _saveFile();
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Tutaj znajduje się zawartość jsona',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
