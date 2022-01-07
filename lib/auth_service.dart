import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  firebaseSignUp(String mail, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return ("");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('Zayıf şifre');
      } else if (e.code == 'email-already-in-use') {
        return ('Bu email daha önce kullanıldı.');
      }
    } catch (e) {
      print(e);
    }
  }

  firebaseSignIn(String tcNo, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: tcNo, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Kullanıcı bulunamadı');
      } else if (e.code == 'wrong-password') {
        print('Yanlış Şifre');
      }
    }
  }

  firebaseSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }

  firebaseUserDelete() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  firestoreUserSet(UserModel _userModel) {
    var _userJsonModel = UserModelConverter().userModelToJson(_userModel);
    FirebaseFirestore.instance
        .collection('users')
        .doc(_userModel.userMail)
        .set(_userJsonModel);
  }

  Future<UserModel> firestoreUserGet(String mail) async {
    var _userget =
        await FirebaseFirestore.instance.collection('users').doc(mail).get();
    UserModel _user = UserModelConverter().userModelFromJson(_userget.data());
    return _user;
  }

  firestoreUserDelete(String mail) {
    FirebaseFirestore.instance.collection('users').doc(mail).delete();
  }
}
