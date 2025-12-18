class AuthModel {
  final String userName;
  final String passcode;
  final String userEmail;

  AuthModel({
    required this.userName,
    required this.passcode,
    required this.userEmail,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userName: json['userName'],
      passcode: json['passcode'],
      userEmail: json['userEmail'],
    );
  }
}
