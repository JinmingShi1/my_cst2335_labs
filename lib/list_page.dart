import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/dao/todo_dao.dart';
import 'package:my_cst2335_labs/database/database.dart';
import 'package:my_cst2335_labs/models/itemEntity.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<Item> items = [];
  late ToDoDao toDoDao;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final database = await $FloorTodoDatabase.databaseBuilder('todo_app_database.db').build();
    toDoDao = database.todoDao;
    toDoDao.findAllToDoItems().then((list) {
      print("tmpItems: ${list}");
      setState(() {
        items = list;
      });
    });
  }

  void showDeleteDialog(int rowNum) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm to delete'),
          content: Text('Are you sure to delete "${items[rowNum]}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Item currentItem = items[rowNum];
                setState(() {
                  items.removeAt(rowNum);
                });
                Navigator.of(context).pop(); // Close dialog
                await toDoDao.deleteToDoItem(currentItem);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('List Page')
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Type the item here",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        hintText: "Type the quantity here",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isEmpty || _quantityController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Name or quantity cannot be empty'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      // add new item
                      Item newItem = Item(itemName: _nameController.text, quantity: _quantityController.text);
                      final insertedId = await toDoDao.insertToDoItem(newItem);
                      newItem.id = insertedId;

                      setState(() {
                        items.add(newItem);
                        _nameController.clear();
                        _quantityController.clear();
                      });
                    },
                    child: Text('Add Item'),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20.0),
                  itemCount: items.length,
                  itemBuilder: (context, rowNum) {
                    return GestureDetector(
                      onLongPress: () {
                        showDeleteDialog(rowNum);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${items[rowNum].id}: ${items[rowNum].itemName}:${items[rowNum].quantity}", textAlign: TextAlign.center),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
