import 'package:voicecook/feature/auth/data/auth_model.dart';

class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String useremail;
  final String passCode;

  LoginEvent({required this.useremail, required this.passCode});
}

class SignUpEvent extends AuthEvent {
  final AuthModel authModel;

  SignUpEvent({required this.authModel});
}
