class UserModel {
  final String name;
  final String email;
  final String phoneNum;
  final String age;
  final String address;
  final String rating;
  final String gender;
  final String foodType;
  final String category;
  final String imageUrl;
  UserModel({
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.age,
    required this.address,
    required this.rating,
    required this.gender,
    required this.foodType,
    required this.category,
    required this.imageUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNum: json['phoneNum'] ?? '',
      age: json['age'] ?? '',
      address: json['address'] ?? '',
      rating: json['rating'] ?? '',
      gender: json['gender'] ?? '',
      foodType: json['foodType'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
