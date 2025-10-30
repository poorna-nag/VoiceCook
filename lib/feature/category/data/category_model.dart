class CategoryModel {
  final String imageUrl;
  final String categoryName;

  CategoryModel({required this.imageUrl, required this.categoryName});

  Map<String, dynamic> toMap() => {
    "imageUrl": imageUrl,
    "categotyName": categoryName,
  };
}
