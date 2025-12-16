class UserModel {
  final String name;
  final String phoneNum;
  final String age;
  final String address;
  final String rateing;
  final String gender;
  final String foodType;
  final String categoty;
  final String imageUrl;
  UserModel({
    required this.name,
    required this.phoneNum,
    required this.age,
    required this.address,
    required this.rateing,
    required this.gender,
    required this.foodType,
    required this.categoty,
    required this.imageUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phoneNum: json['phoneNum'],
      age: json['age'],
      address: json['address'],
      rateing: json['rateing'],
      gender: json['gender'],
      foodType: json['foodType'],
      categoty: json['categoty'],
      imageUrl: json['imageUrl'],
    );
  }
}
