import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_2/Auth/helper_function.dart';
import 'package:day_2/Auth/login.dart';
import 'package:day_2/Auth/phone_login.dart';
import 'package:day_2/provider/auth_provider.dart';
import 'package:day_2/screen/Home.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/info_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/entry_point.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SpleshScreen()
      ),
    );
  }
}

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return AnimatedSplashScreen(
      backgroundColor: Yellow,
      splash: Container(
        height: h,
        width: w,
        color: const Color.fromRGBO(254, 254, 241, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Storyscape.png',
              // fit: BoxFit.fill,
            ),
            Text(
              "StoryScape",
              style: GoogleFonts.calistoga(
                  color: const Color.fromRGBO(31, 67, 57, 1),
                  fontSize: 35),
            ),
            Text(
              "Unleash Your Imagination",
              style: GoogleFonts.quicksand(
                  color: const Color.fromRGBO(177, 133, 109, 1),
                  fontSize: 22),
            ),
            SizedBox(height: h*0.08,),
            const CircularProgressIndicator(color: Color.fromRGBO(31, 67, 57, 1),)
          ],
        ),
      ),
      // backgroundColor: Color.fromRGBO(254,254,241,100),
      // nextScreen: const Login(),
      nextScreen:_isSignedIn? EntryPoint():Login(),
      splashIconSize: 1000,
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      // splashTransition: SplashTransition.fadeTransition,
    );
  }
}

