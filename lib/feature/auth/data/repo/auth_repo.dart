import 'package:voicecook/feature/auth/data/auth_model.dart';

abstract class AuthRepo {
  Future<bool> singInUser(AuthModel request);

  Future<bool> logInUser(String email, String passCode);
  // Future<bool> loginWithGoogle();
  Future<bool> logOut();
}
