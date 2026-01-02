class VideoModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String cookTime;
  final String difficulty;
  final String category;
  final String ingredients;
  final String steps;
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
      ingredients: data['ingredients'] ?? '',
      // ingredients: List<String>.from(data['ingredients'] ?? []),
      // steps: List<String>.from(data['steps'] ?? []),
      steps: data['steps'] ?? '',
      calories: data['calories'] ?? 0,
    );
  }
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

  VideoModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? cookTime,
    String? difficulty,
    String? category,
    String? ingredients,
    String? steps,
    String? calories,
  }) {
    return VideoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      cookTime: cookTime ?? this.cookTime,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
    );
  }
}
