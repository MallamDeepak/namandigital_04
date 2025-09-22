import 'package:flutter/material.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final void Function(String, List) onCategorySelected;

  const CategorySelectionScreen({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Category'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final cat = categories[i];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              leading: Icon(cat['icon'], color: Colors.orange, size: 32),
              title: Text(cat['label'], style: const TextStyle(fontSize: 20)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
              onTap: () => onCategorySelected(cat['label'], cat['questions']),
            ),
          );
        },
      ),
    );
  }
}