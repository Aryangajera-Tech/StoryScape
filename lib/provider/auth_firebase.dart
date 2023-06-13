import 'package:day_2/Auth/helper_function.dart';
import 'package:day_2/Auth/login.dart';
import 'package:day_2/provider/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class AuthFirebase {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Signin email & password
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        // uname = user.displayName;
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Signup email & password
  Future registerUserWithEmailandPassword(String fullName, String email,
      String password) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password)).user!;
      if (user != null) {
        // call our database service to update the user data.
        // uname = user.displayName;
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await _firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

}