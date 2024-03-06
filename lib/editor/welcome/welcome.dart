import 'dart:convert';

import 'package:darth_flutter/editor/editor-manager.dart';
import 'package:darth_flutter/editor/file-manager.dart';
import 'package:darth_flutter/service/adventure_manager.dart';
import 'package:darth_flutter/service/model/adventure_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}


class _WelcomeScreenState extends State<WelcomeScreen> {
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String contents = await file.readAsString();
      setState(() {
        EditorManager().loadAdventureData(contents);
        FileManager().setCurrentFilePath(result.files.single.path!);
        Navigator.pushReplacementNamed(context, '/home');
      });

    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Darth Flutter - Edytor Przygody'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _openFilePicker,
                child: Text('Wczytaj plik przygody'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text('Utwórz nową przygodę'),
              )
            ],
          ),
        ),
      ),
    );
  }
}