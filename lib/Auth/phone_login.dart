import 'package:country_picker/country_picker.dart';
import 'package:day_2/provider/auth_provider.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final TextEditingController phoneController = TextEditingController();
String phoneNumber = phoneController.text.trim();

Country selectedCountry = Country(
  phoneCode: "91",
  countryCode: "IN",
  e164Sc: 0,
  geographic: true,
  level: 1,
  name: "India",
  example: "India",
  displayName: "India",
  displayNameNoCountryCode: "IN",
  e164Key: "",
);

class phone_login extends StatefulWidget {
  const phone_login({super.key});

  @override
  State<phone_login> createState() => _phone_loginState();
}

class _phone_loginState extends State<phone_login> {



  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: h-39.4,
            color:Yellow,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
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
                  const SizedBox(height: 10),
                  const Text(
                    "Add your phone number. We'll send you a verification code",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Green,
                    controller: phoneController,
                    style:  TextStyle(
                      fontSize: 18,
                      color: Green,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 550,
                                  ),
                                  onSelect: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                    });
                                  });
                            },
                            child: Text(
                              "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                              height: 25,
                              width: 25,
                              margin: const EdgeInsets.all(10.0),
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Green,
                              ),
                              child:  Icon(
                                Icons.done,
                                color: Yellow,
                                size: 17,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                        text: "Send OTP", onPressed: () => sendPhoneNumber()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
