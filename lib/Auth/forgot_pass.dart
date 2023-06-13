import 'package:day_2/Auth/login.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgote_Pass extends StatefulWidget {
  const Forgote_Pass({Key? key}) : super(key: key);

  @override
  State<Forgote_Pass> createState() => _Forgote_PassState();
}

class _Forgote_PassState extends State<Forgote_Pass> {
  final formKey = GlobalKey<FormState>();
  String forgotpasswordemail = "";

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Yellow,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:20),
                child: Column(
                  children: [
                    Stack(
                        children:[
                          Center(
                            child: Image.asset(
                              'assets/images/Storyscape.png',
                              height: h*0.28,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding:  EdgeInsets.only(top: h*0.22),
                              child: Text(
                                "StoryScape",
                                style: GoogleFonts.calistoga(
                                    color: Green,
                                    fontSize: 25),
                              ),
                            ),
                          ),
                        ]
                    ),
                    Text(
                      "Unleash Your Imagination",
                      style: GoogleFonts.quicksand(
                          color: Color.fromRGBO(177, 133, 109, 1),
                          fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),
                      child: Divider(
                        color:Green,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height:3),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(color: Brown,borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Forgot password",style:TextStyle(color:Yellow,fontWeight: FontWeight.bold,fontSize: 15)),
                              )),
                          SizedBox(height: h * 0.02),
                          TextFormField(
                            onChanged: (val) {
                              setState(() {
                                forgotpasswordemail = val;
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
                              contentPadding: EdgeInsets.all(10),
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
                          SizedBox(height: h * 0.02),
                          SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: CustomButton(
                                  text: "Forgot password",
                                  onPressed: () {
                                    var forgotEmail = forgotpasswordemail.trim();
                                    if (formKey.currentState!.validate()){
                                      try {
                                        FirebaseAuth.instance
                                            .sendPasswordResetEmail(email: forgotEmail)
                                            .then((value) => {
                                          showSnackbar(context,Colors.green,"Email sent"),
                                          nextScreenReplace(context, Login())
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        showSnackbar(context, Colors.red,'Email not send');
                                        if (kDebugMode) {
                                          print("Error $e");
                                        }
                                      };
                                    }

                                  }
                                  )
                          ),
                          InkWell(
                              onTap: () {
                                nextScreenReplace(context, Login());
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'Back to login',
                                  style: TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
