import 'package:day_2/Auth/helper_function.dart';
import 'package:day_2/provider/auth_firebase.dart';
import 'package:day_2/screen/entry_point.dart';
import 'package:day_2/utils/utils.dart';
import 'package:day_2/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class sign_up extends StatefulWidget {
  const sign_up({Key? key}) : super(key: key);

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;
  String email = "";
  String password = "";
  String fullName = "";
  String photo = "";
  AuthFirebase authService = AuthFirebase();

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreen(context, EntryPoint());
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
      body:_isLoading
          ? Center(
          child: SpinKitRipple(color:Green))
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height:h*0.02),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    fullName = val;
                  });
                },
                validator: (val) {
                  if (val!.isNotEmpty) {
                    return null;
                  } else {
                    return "Name cannot be empty";
                  }
                },
                style: TextStyle(fontSize: 15.0),
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 10),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Green,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Green,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                cursorColor: Green,
              ),
              SizedBox(height:h*0.01),
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
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Green,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Green,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                cursorColor: Green,
              ),
              SizedBox(height:h*0.01),
              TextFormField(
                obscureText: _obscureText,
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
                style: TextStyle(fontSize: 15.0),
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 10),
                  contentPadding: EdgeInsets.all(10),
                  hintText: "password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Green,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Green,
                    ),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Green,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                cursorColor: Green,
              ),
              SizedBox(height:h*0.02),
              SizedBox(
                  width: w,
                  height: 50,
                  child: CustomButton(text: "Sign Up", onPressed:(){
                    register();
                  })),
            ],
          ),
        ),
      )
    );
  }
}
