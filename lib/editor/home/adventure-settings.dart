import 'package:flutter/material.dart';

class AdventureSettingsDrawer extends StatefulWidget {

  final VoidCallback onSave;

  const AdventureSettingsDrawer({super.key, required this.onSave});

  @override
  State<AdventureSettingsDrawer> createState() => _AdventureSettingsDrawerState();
}

class _AdventureSettingsDrawerState extends State<AdventureSettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Ustawienia edytora przygody',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Zapisz przygodę'),
            onTap: () {
              setState(() {
                widget.onSave();
              });
            },
          ),
        ],
      ),
    );
  }
}
