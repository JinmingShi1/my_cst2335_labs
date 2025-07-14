import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/dao/todo_dao.dart';
import 'package:my_cst2335_labs/database/database.dart';
import 'package:my_cst2335_labs/models/itemEntity.dart';

import 'DetailPage.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<Item> items = [];
  Item? selectedItem;
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

  Future<void> _deleteItem(Item item) async {
    await toDoDao.deleteToDoItem(item);
    setState(() {
      items.remove(item);
      if (selectedItem == item) selectedItem = null;
    });
  }

  Widget _buildList(bool isLargeScreen) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text('${item.id} : ${item.itemName} : ${item.quantity}'),
          onTap: () {
            if (isLargeScreen) {
              setState(() {
                selectedItem = item;
              });
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    item: item,
                    onDelete: () {
                      _deleteItem(item);
                      Navigator.of(context).pop();
                    },
                    onClose: () => Navigator.of(context).pop(),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildDetail(Item item) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${item.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Name: ${item.itemName}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Quantity: ${item.quantity}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _deleteItem(item),
                  child: const Text('Delete'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedItem = null;
                    });
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > size.height && size.width > 720;

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
                child: isLargeScreen
                    ? Row(
                        children: [
                          Expanded(child: _buildList(isLargeScreen)),
                          Expanded(
                            child: selectedItem != null
                                ? _buildDetail(selectedItem!)
                                : const Center(child: Text('Select an item')),
                          ),
                        ],
                      ) : _buildList(isLargeScreen),
              ),
            ],
          ),
        )
      ),
    );
  }
}
