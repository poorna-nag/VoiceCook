import 'package:flutter/material.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/presentation/pages/card_view.dart';

class RecipeDetailScreen extends StatefulWidget {
  final List<RecipeModel> recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: CardView(recipes: widget.recipe),
    );
  }
}
