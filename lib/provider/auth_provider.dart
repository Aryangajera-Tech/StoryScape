import 'package:day_2/Auth/helper_function.dart';
import 'package:day_2/Auth/otp_screen.dart';
import 'package:day_2/Auth/phone_login.dart';
import 'package:day_2/provider/database_services.dart';
import 'package:day_2/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/login.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _uid;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // signin with phone
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
              showSnackbar(context, Colors.red, "please enter proper number");
              throw Exception(error.message);
            },
          codeSent: (verificationId, forceResendingToken) {
            CircularProgressIndicator();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackbar(context,Colors.red, e.message.toString());
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        await HelperFunctions.saveUserLoggedInStatus(true);
        DatabaseService(uid: user.uid).savingUserDataphone(selectedCountry.phoneCode,phoneNumber);
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, Colors.red,e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }


  // google login


// DATABASE OPERTAIONS
//   Future<bool> checkExistingUser() async {
//     DocumentSnapshot snapshot =
//         await _firebaseFirestore.collection("users").doc(_uid).get();
//     if (snapshot.exists) {
//       print("USER EXISTS");
//       return true;
//     } else {
//       print("NEW USER");
//       return false;
//     }
//   }
//
//   void saveUserDataToFirebase({
//     required BuildContext context,
//     required UserModel userModel,
//     required File profilePic,
//     required Function onSuccess,
//   }) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       // uploading image to firebase storage.
//       await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
//         userModel.profilePic = value;
//         userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
//         userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
//         userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
//       });
//       _userModel = userModel;
//
//       // uploading to database
//       await _firebaseFirestore
//           .collection("users")
//           .doc(_uid)
//           .set(userModel.toMap())
//           .then((value) {
//         onSuccess();
//         _isLoading = false;
//         notifyListeners();
//       });
//     } on FirebaseAuthException catch (e) {
//       showSnackbar(context, e.message.toString(),"Aryan");
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<String> storeFileToStorage(String ref, File file) async {
//     UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//
//   Future getDataFromFirestore() async {
//     await _firebaseFirestore
//         .collection("users")
//         .doc(_firebaseAuth.currentUser!.uid)
//         .get()
//         .then((DocumentSnapshot snapshot) {
//       _userModel = UserModel(
//         name: snapshot['name'],
//         email: snapshot['email'],
//         createdAt: snapshot['createdAt'],
//         bio: snapshot['bio'],
//         uid: snapshot['uid'],
//         profilePic: snapshot['profilePic'],
//         phoneNumber: snapshot['phoneNumber'],
//       );
//       _uid = userModel.uid;
//     });
//   }
//
//   // STORING DATA LOCALLY
//   Future saveUserDataToSP() async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//     await s.setString("user_model", jsonEncode(userModel.toMap()));
//   }
//
//   Future getDataFromSP() async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//     String data = s.getString("user_model") ?? '';
//     _userModel = UserModel.fromMap(jsonDecode(data));
//     _uid = _userModel!.uid;
//     notifyListeners();
//   }
//
//   Future userSignOut() async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//     await _firebaseAuth.signOut();
//     _isSignedIn = false;
//     notifyListeners();
//     s.clear();
//   }
}
