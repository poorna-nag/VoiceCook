class VideoModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final String cookTime;
  final String difficulty;
  final String category;
  final String ingredients;
  final String steps;
  final String calories;
  final String? userId;

  VideoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.cookTime,
    required this.difficulty,
    required this.category,
    required this.ingredients,
    required this.steps,
    required this.calories,
    this.userId,
  });
  factory VideoModel.fromJson(Map<String, dynamic> data, String id) {
    return VideoModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      cookTime: data['cookTime'] ?? '',
      difficulty: data['difficulty'] ?? '',
      category: data['category'] ?? '',
      ingredients: data['ingredients'] ?? '',
      steps: data['steps'] ?? '',
      calories: data['calories']?.toString() ?? '0',
      userId: data['userId'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'cookTime': cookTime,
      'difficulty': difficulty,
      'category': category,
      'ingredients': ingredients,
      'steps': steps,
      'calories': calories,
      'userId': userId,
    };
  }

  VideoModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? videoUrl,
    String? cookTime,
    String? difficulty,
    String? category,
    String? ingredients,
    String? steps,
    String? calories,
    String? userId,
  }) {
    return VideoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      cookTime: cookTime ?? this.cookTime,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      userId: userId ?? this.userId,
    );
  }
}
