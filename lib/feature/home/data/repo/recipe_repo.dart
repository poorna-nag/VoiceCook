import 'package:voicecook/feature/home/data/recipe_model.dart';

abstract class RecipeRepo {
  Future<List<RecipeModel>> getRecipe();
}
