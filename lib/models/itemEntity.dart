import 'package:floor/floor.dart';

@Entity(tableName: 'items')
class Item {
  @PrimaryKey(autoGenerate: true)
  int? id; // Nullable for new items before insertion

  String? itemName;
  String? quantity;

  Item({this.id, required this.itemName, required this.quantity});

  @override
  String toString() {
    return '{id: $id, itemName: $itemName, quantity: $quantity}';
  }

}