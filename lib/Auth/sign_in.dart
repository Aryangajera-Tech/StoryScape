import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_2/Auth/forgot_pass.dart';
import 'package:day_2/Auth/helper_function.dart';
import 'package:day_2/Auth/login.dart';
import 'package:day_2/provider/auth_firebase.dart';
import 'package:day_2/provider/database_services.dart';
import 'package:day_2/screen/entry_point.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class sign_in extends StatefulWidget {
  const sign_in({Key? key}) : super(key: key);

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthFirebase authService = AuthFirebase();

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          // saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          nextScreenReplace(context, EntryPoint());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    void _togglePasswordVisibility() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Scaffold(
        backgroundColor: Yellow,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Green),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: h,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.02),
                        TextFormField(
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 10),
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Green,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Green,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          cursorColor: Green,
                        ),
                        SizedBox(height: h * 0.01),
                        TextFormField(
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: _obscureText,
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 10),
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Green,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Green,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Green,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          cursorColor: Green,
                        ),
                        SizedBox(height: h * 0.01),
                        Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: () {
                                  nextScreen(context, Forgote_Pass());
                                },
                                child: const Text("Forgot password ?",
                                    style: TextStyle(
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w500)))),
                        SizedBox(height: h * 0.01),
                        SizedBox(
                            width: w,
                            height: 50,
                            child: CustomButton(
                                text: "Sign In",
                                onPressed: () {
                                  login();
                                })),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
