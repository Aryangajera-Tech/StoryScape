 // ignore_for_file: unnecessary_const
import 'package:day_2/Auth/helper_function.dart';
import 'package:day_2/Auth/phone_login.dart';
import 'package:day_2/provider/database_services.dart';
import 'package:day_2/screen/Home.dart';
import 'package:day_2/screen/entry_point.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/info_card.dart';
import 'package:day_2/widgets/tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

User? user = FirebaseAuth.instance.currentUser;


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);
        user = userCredential.user;
        print("Google SignIn ~~>> ${user.toString()}");
        await DatabaseService(uid: user!.uid).savingUserData(user!.displayName.toString(), user!.email.toString());
        await HelperFunctions.saveUserLoggedInStatus(true);
        Navigator.of(context as BuildContext)
            .push(MaterialPageRoute(builder: (context) =>EntryPoint()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print(e.code);
        } else if (e.code == 'invalid-credential') {
          print(e.code);
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("Google SignIn 123~~>> ${user.toString()}");
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color:Yellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    children:[
                      Center(
                        child: Image.asset(
                          'assets/images/Storyscape.png',
                          height: h*0.25,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.only(top: h*0.20),
                          child: Text(
                            "StoryScape",
                            style: GoogleFonts.calistoga(
                                color: Green,
                                fontSize: 24),
                          ),
                        ),
                      ),
                    ]
                  ),
                  Text(
                    "Unleash Your Imagination",
                    style: GoogleFonts.quicksand(
                        color: Brown,
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
                  Container(
                    height: h*0.46,
                      child: tab()
                  ),
                  Row(children:  <Widget>[
                    Expanded(
                        child: Divider(
                          thickness: 2,
                        )),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Or login with",
                          style: TextStyle(fontSize: 15,color:Green)),
                    ),
                    Expanded(
                        child: Divider(
                          thickness: 2,
                        )),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: Green,
                          child: InkWell(
                            onTap: () {
                              signInWithGoogle();
                            },
                            child: Icon(
                              Icons.email_rounded,
                              size: 30,
                              color: Yellow,
                            ),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: Green,
                          child: InkWell(
                            onTap: () {
                              nextScreen(context, phone_login());
                            },
                            child: Icon(
                              Icons.phone,
                              size: 30,
                              color: Yellow,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor:Yellow,
    );
  }
}