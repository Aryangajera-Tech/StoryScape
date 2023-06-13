import 'package:day_2/Auth/helper_function.dart';
import 'package:day_2/Auth/phone_login.dart';
import 'package:day_2/provider/auth_provider.dart';
import 'package:day_2/screen/entry_point.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../provider/database_services.dart';


class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  bool _isLoading = false;
  AuthProvider authService = AuthProvider();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Yellow,
      body: SafeArea(
        child: _isLoading
            ?  Center(
                child: CircularProgressIndicator(
                  color: Green,
                ),
              )
            : SingleChildScrollView(
          child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                    child: Column(
                      children: [
                        Stack(
                            children:[
                              Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child:  Icon(Icons.arrow_back,color: Green),
                                ),
                              ),
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
                        const Text(
                          "Verification",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter the OTP send to your phone number",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Green,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton(
                            text: "Verify",
                            onPressed: () {
                              if (otpCode != null) {
                                verifyOtp(context, otpCode!);
                              } else {
                                showSnackbar(context, Colors.red,"Enter 6-Digit code",);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Didn't receive any code?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                        const SizedBox(height: 15),
                         Text(
                          "Resend New Code",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
      ),
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        HelperFunctions.saveUserLoggedInStatus(true);
        // DatabaseService(uid:widget.verificationId).savingUserDataphone(selectedCountry.phoneCode,phoneNumber);
        nextScreen(context,EntryPoint());
      },
    );
  }
}
