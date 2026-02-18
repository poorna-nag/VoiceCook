import 'package:voicecook/feature/user_profile/data/repo/user_repo.dart';
import 'package:voicecook/feature/user_profile/data/user_model.dart';

class UserRepoImpl extends UserRepo {
  @override
  Future<UserModel> getUser() async {
    await Future.delayed(Duration(seconds: 1));
    return UserModel(
      name: "Poorna Nag",
      email: "poornanag@example.com",
      phoneNum: 'XXXXXX8976',
      age: '26',
      address: 'Mysuru',
      rating: '4.1',
      gender: 'female',
      foodType: 'Veg and Non-veg',
      category: 'all',
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287',
    );
  }
}
