import 'package:flutter/material.dart';

import '../editor-manager.dart';

class ParagraphProperties extends StatefulWidget {
  const ParagraphProperties({super.key});

  @override
  State<ParagraphProperties> createState() => _ParagraphPropertiesState();
}

class _ParagraphPropertiesState extends State<ParagraphProperties> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Ilość zakładek
      child: Scaffold(
        appBar: AppBar(
          title: Text('Właściwości Paragrafu'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Edytor Graficzny'),
              Tab(text: 'Edytor Tekstowy'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text(EditorManager().selectedParagraphId),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: TextEditingController(
                      // text: EditorManager().adventureDataAsJson),
                      text: EditorManager().selectedParagraphAdventureDataJson()),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Tutaj znajduje się zawartość jsona',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
