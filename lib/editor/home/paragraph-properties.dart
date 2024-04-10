import 'package:flutter/material.dart';

import '../editor-manager.dart';

class ParagraphProperties extends StatefulWidget {
  final String? id;
  const ParagraphProperties(this.id);

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
  }

  void updateTextEditor() {
    _controller.text = EditorManager().selectedParagraphAdventureDataJson();
  }
  @override
  void didUpdateWidget(ParagraphProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      updateTextEditor();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextFieldBlur() {
    print('Text field blurred. Value: ${_controller.text}');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Właściwości Paragrafu ${widget.id ?? "brak"} ' + EditorManager().selectedParagraphId ),
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
