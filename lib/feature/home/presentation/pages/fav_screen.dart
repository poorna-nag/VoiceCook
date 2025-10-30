import 'package:flutter/material.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';

class FavScreen extends StatelessWidget {
  final List<RecipeModel> favItems;
  const FavScreen({super.key, required this.favItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: favItems.isEmpty
          ? const Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favItems.length,
              itemBuilder: (context, index) {
                final item = favItems[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(item.imageUrl, width: 60),
                    title: Text(item.name),
                    subtitle: Text(item.imageUrl),
                  ),
                );
              },
            ),
    );
  }
}
