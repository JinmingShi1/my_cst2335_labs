import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<String> items = [];

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
              onPressed: () {
                setState(() {
                  items.removeAt(rowNum);
                });
                Navigator.of(context).pop(); // Close dialog
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
                    onPressed: () {
                      if (_nameController.text.isEmpty || _quantityController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Name or quantity cannot be empty'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        items.add("${_nameController.text}: ${_quantityController.text}");
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
                        child: Text("${rowNum + 1}: ${items[rowNum]}", textAlign: TextAlign.center),
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
