import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/itemEntity.dart';

class DetailPage extends StatelessWidget {
  final Item item;
  final VoidCallback onDelete;
  final VoidCallback onClose;

  const DetailPage({
    required this.item,
    required this.onDelete,
    required this.onClose,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: Padding(
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
                  onPressed: onDelete,
                  child: const Text('Delete'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onClose,
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}