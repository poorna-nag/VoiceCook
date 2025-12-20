import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voicecook/feature/auth/data/auth_model.dart';
import 'package:voicecook/feature/auth/data/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStrore = FirebaseFirestore.instance;
  @override
  Future<bool> logInUser(String email, String passCode) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: passCode);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logOut() async {
    await auth.signOut();
    return false;
  }

  @override
  Future<bool> singInUser(AuthModel request) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: request.userEmail,
        password: request.passcode,
      );
      User? user = userCredential.user;
      await fireStrore.collection('user').doc(user!.uid).set({
        "userId": user.uid,
        "useremail": user.email,
        "userName": request.userName,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  // @override
  // Future<bool> loginWithGoogle() {
  //    final Google
  // }
}
