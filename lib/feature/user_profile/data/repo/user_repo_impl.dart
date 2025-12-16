import 'package:voicecook/feature/user_profile/data/repo/user_repo.dart';
import 'package:voicecook/feature/user_profile/data/user_model.dart';

class UserRepoImpl extends UserRepo {
  @override
  Future<UserModel> getUser() async {
    await Future.delayed(Duration(seconds: 1));
    return UserModel(
      name: "Poorna Nag",
      phoneNum: 'XXXXXX8976',
      age: '26',
      address: 'Mysuru',
      rateing: '4.1',
      gender: 'female',
      foodType: 'Veg and Non-veg',
      categoty: 'all',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287',
    );
  }
}
