import 'package:floor/floor.dart';
import '../models/itemEntity.dart';

@dao
abstract class ToDoDao {
  @insert
  Future<int> insertToDoItem(Item item);

  @Query('SELECT * FROM items')
  Future<List<Item>> findAllToDoItems();

  @delete
  Future<int> deleteToDoItem(Item item);

}