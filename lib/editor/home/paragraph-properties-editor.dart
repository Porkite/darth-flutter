import 'package:flutter/material.dart';

import '../../service/model/adventure_models.dart';

enum ParagraphTypeLabel {
  text('Tekst', ParagraphType.text),
  itemCatcher('Łapacz itemsów', ParagraphType.itemCatcher),
  shop('Sklep', ParagraphType.shop);

  const ParagraphTypeLabel(this.label, this.type);
  final String label;
  final ParagraphType type;
}



class ParagraphPropertiesEditorWidget extends StatefulWidget {
  final Paragraph paragraph;

  ParagraphPropertiesEditorWidget({required this.paragraph});

  @override
  _ParagraphPropertiesEditorWidgetState createState() =>
      _ParagraphPropertiesEditorWidgetState();
}

class _ParagraphPropertiesEditorWidgetState
    extends State<ParagraphPropertiesEditorWidget> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  final TextEditingController _controllerIdentifier = TextEditingController();
  final TextEditingController _controllerText = TextEditingController();

  get paragraphTypeController => null;

  @override
  void initState() {
    super.initState();
    _controllerIdentifier.text = widget.paragraph.identifier;
    _controllerText.text = widget.paragraph.text; // Ustawienie początkowej wartości
// Ustawienie początkowej wartości
  }

  @override
  void didUpdateWidget(ParagraphPropertiesEditorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.paragraph.identifier != oldWidget.paragraph.identifier) {
      _controllerIdentifier.text = widget.paragraph.identifier;
      _controllerText.text = widget.paragraph.text;
    }
  }

  saveParagraph() {
    if (formKey.currentState!.validate()) {
      print('zapisane');
    }
  }

  stringToParagraphTypeLabel(String type) {
    switch (type) {
      case 'text':
        return ParagraphTypeLabel.text;
      case 'itemCatcher':
        return ParagraphTypeLabel.itemCatcher;
      case 'shop':
        return ParagraphTypeLabel.shop;
      default:
        return ParagraphTypeLabel.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(

        children: [
          TextFormField(
            controller: _controllerIdentifier,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Identifier',
            ),
            validator: (value) {
              if (value!.isEmpty ||
                  RegExp((r'^[a-zA-Z0-9]+$')).hasMatch(value) == false) {
                return 'Please enter correct identifier';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                widget.paragraph.identifier = value;
              });
            },
          ),
          TextFormField(
            controller: _controllerText,
            minLines: 1,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Text',
            ),
            onChanged: (value) {
              setState(() {
                widget.paragraph.text = value;
              });
            },

          ),
          CheckboxListTile(
              value: widget.paragraph.options['start'] ?? false,
              title: Text("Is start paragraph"),  // The named parameter 'title' isn't defined.
              onChanged: (value) {
                setState(() {
                  widget.paragraph.options['start'] = value;
                });
              }),
          DropdownMenu<ParagraphTypeLabel>(
            initialSelection: stringToParagraphTypeLabel(widget.paragraph.type),
            controller: paragraphTypeController,
            // requestFocusOnTap is enabled/disabled by platforms when it is null.
            // On mobile platforms, this is false by default. Setting this to true will
            // trigger focus request on the text field and virtual keyboard will appear
            // afterward. On desktop platforms however, this defaults to true.
            requestFocusOnTap: true,
            label: const Text('Typ paragrafu'),
            onSelected: (ParagraphTypeLabel? paragraphType) {
              setState(() {
                widget.paragraph.setType(paragraphType!.type);
              });
            },
            dropdownMenuEntries: ParagraphTypeLabel.values
                .map<DropdownMenuEntry<ParagraphTypeLabel>>(
                    (ParagraphTypeLabel paragraphType) {
                  return DropdownMenuEntry<ParagraphTypeLabel>(
                    value: paragraphType,
                    label: paragraphType.label,
                    enabled: true,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
