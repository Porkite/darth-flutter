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
            // Widżety dla pierwszej zakładki
            Center(
              child: Text('Content for Tab 1'),
            ),
            // Widżety dla drugiej zakładki
            Center(
              child: Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: EditorManager().adventureDataAsJson),
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
