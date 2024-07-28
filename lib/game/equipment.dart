import 'package:darth_flutter/service/items_manager.dart';
import 'package:flutter/material.dart';

import '../service/game_manager.dart';
import '../service/model/equipment_state.dart';
import 'controls/floating-action-button.dart';

class EquipmentWidget extends StatefulWidget {
  const EquipmentWidget({super.key});

  @override
  State<EquipmentWidget> createState() => _EquipmentWidget();
}

class _EquipmentWidget extends State<EquipmentWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var itemsWidgets = [];
    for (var item in GameManager().getPlayerEquipment().getItems()) {
      itemsWidgets.add(mapItemToItemWidget(item));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Ekwipunek',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/equipment/chest.png"),
              radius: 40,
              backgroundColor: Colors.grey,
            )),
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            children: [...itemsWidgets],
          ),
        ),
      ],
    );
  }

  ItemWidget mapItemToItemWidget(EquipmentItem item) {
    var i = ItemsManager().items[item.itemIdentifier];
    if (i == null) {
      throw Exception(
          "Should not happen, item in inventory is not in configuration");
    }
    return ItemWidget(i.name, i.iconPath);
  }
}

class ItemWidget extends StatelessWidget {
  String name;
  String iconPath;

  ItemWidget(this.name, this.iconPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(iconPath),
          height: 64,
          width: 64,
          fit: BoxFit.cover,
        ),
        Text(name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ))
      ],
    );
  }
}

class EquipmentButton {
  static Widget getEquipmentButton(Function setState) {
    var playerEquipment = GameManager().getPlayerEquipment();

    var closeButton = DarthFloatingActionButton(
      onPressed: () {
        setState(() {
          GameManager().setBlockMovement(false);
          playerEquipment.close();
        });
      },
      child: const Icon(Icons.no_backpack),
    );

    var openButton = DarthFloatingActionButton(
      onPressed: () {
        setState(() {
          GameManager().setBlockMovement(true);
          playerEquipment.open();
        });
      },
      child: const Icon(Icons.shopping_bag),
    );

    return playerEquipment.isOpen() ? closeButton : openButton;
  }
}
