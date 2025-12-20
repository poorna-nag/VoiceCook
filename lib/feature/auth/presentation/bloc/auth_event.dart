import 'package:voicecook/feature/auth/data/auth_model.dart';

class AuthEvent {}

class LogingEvent extends AuthEvent {
  final String useremail;
  final String passCode;

  LogingEvent({required this.useremail, required this.passCode});
}

class SingInEvent extends AuthEvent {
  final AuthModel authModel;

  SingInEvent({required this.authModel});
}
