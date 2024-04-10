import 'package:flutter/material.dart';

import '../editor-manager.dart';

class ParagraphProperties extends StatefulWidget {
  const ParagraphProperties({Key? key}) : super(key: key);

  @override
  State<ParagraphProperties> createState() => _ParagraphPropertiesState();
}

class _ParagraphPropertiesState extends State<ParagraphProperties> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _onTextFieldBlur();
      }
    });
    _controller.text = EditorManager().selectedParagraphAdventureDataJson();
    print("test");
  }

  void updateTextEditor() {
    _controller.text = EditorManager().selectedParagraphAdventureDataJson();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextFieldBlur() {
    print('Text field blurred. Value: ${_controller.text}');
    // Tutaj możesz wykonać odpowiednie działania po zblurrowaniu kontrolera tekstu
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Właściwości Paragrafu ' + EditorManager().selectedParagraphId),
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
                  controller: _controller,
                  focusNode: _focusNode,
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
