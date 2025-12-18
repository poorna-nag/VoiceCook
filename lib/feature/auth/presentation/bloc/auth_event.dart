import 'package:voicecook/feature/auth/data/auth_model.dart';

class AuthEvent {}

class LogingEvent extends AuthEvent {
  final String userName;
  final String passCode;

  LogingEvent({required this.userName, required this.passCode});
}

class SingInEvent extends AuthEvent {
  final AuthModel authModel;

  SingInEvent({required this.authModel});
}

class NavigateToSinginPageEvent extends AuthEvent {}

class NavigateToLoginPageEvent extends AuthEvent {}
