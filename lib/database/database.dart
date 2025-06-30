import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/todo_dao.dart';
import '../models/itemEntity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Item])
abstract class TodoDatabase extends FloorDatabase {
  ToDoDao get todoDao;
}
