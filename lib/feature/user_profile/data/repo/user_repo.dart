import 'package:voicecook/feature/user_profile/data/user_model.dart';

abstract class UserRepo {
  Future<UserModel> getUser();
}
