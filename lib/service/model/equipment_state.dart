import '../items_manager.dart';

class Item {
  String name;
  String iconPath;

  Item(this.name, this.iconPath);
}

class EquipmentItem {
  String itemIdentifier;

  EquipmentItem(this.itemIdentifier);
}

class EquipmentState {
  static final List<EquipmentItem> initialItems = [EquipmentItem("pretzel")];
  final List<EquipmentItem> _items = [];

  EquipmentState._();

  static initializeEquipment() {
    var equipmentState = EquipmentState._();
    equipmentState._items.addAll(initialItems);
    return equipmentState;
  }

  void addItem(EquipmentItem item) {
    _items.add(item);
  }

  void removeItem(String itemIdentifier) {
    _items.removeWhere((item) => item.itemIdentifier == itemIdentifier);

  }

  List<EquipmentItem> getItems() {
    return _items;
  }
}
