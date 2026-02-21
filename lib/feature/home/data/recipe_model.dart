class RecipeModel {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final String imageUrl;
  final String? time;
  final String? difficulty;
  final String? calories;
  final String? userId;
  bool isFavorite;

  RecipeModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.imageUrl,
    this.time,
    this.difficulty,
    this.calories,
    this.userId,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'categoryId': categoryId,
    'description': description,
    'ingredients': ingredients,
    'steps': steps,
    'imageUrl': imageUrl,
    'time': time,
    'difficulty': difficulty,
    'calories': calories,
    'userId': userId,
  };

  factory RecipeModel.fromJson(Map<String, dynamic> json, [String? id]) =>
      RecipeModel(
        id: id ?? json['id'] ?? '',
        name: json['name'] ?? '',
        categoryId: json['categoryId'] ?? '',
        description: json['description'] ?? '',
        ingredients: List<String>.from(json['ingredients'] ?? []),
        steps: List<String>.from(json['steps'] ?? []),
        imageUrl: json['imageUrl'] ?? '',
        time: json['time'],
        difficulty: json['difficulty'],
        calories: json['calories'],
        userId: json['userId'],
      );
}
