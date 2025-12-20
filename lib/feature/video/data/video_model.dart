class VideoModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String cookTime;
  final String difficulty;
  final String category;
  final List<String> ingredients;
  final List<String> steps;
  final String calories;

  VideoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.cookTime,
    required this.difficulty,
    required this.category,
    required this.ingredients,
    required this.steps,
    required this.calories,
  });
  factory VideoModel.fromJson(Map<String, dynamic> data, String id) {
    return VideoModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      cookTime: data['cookTime'] ?? '',
      difficulty: data['difficulty'] ?? '',
      category: data['category'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      steps: List<String>.from(data['steps'] ?? []),
      calories: data['calories'] ?? 0,
    );
  }
  // Model → Firestore (for admin add feature)
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'cookTime': cookTime,
      'difficulty': difficulty,
      'category': category,
      'ingredients': ingredients,
      'steps': steps,
      'calories': calories,
    };
  }
}
