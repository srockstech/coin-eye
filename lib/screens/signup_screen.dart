import 'package:coin_eye/utilities/constants.dart';
import 'package:coin_eye/utilities/input_text_field.dart';
import 'package:coin_eye/utilities/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'otp_verification.dart';

class SignUpScreen extends StatefulWidget {
  final Function onTap;

  SignUpScreen({@required this.onTap});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String phoneNumber;
  bool showSpinner = false;
  bool hiddenPassword = true;
  List<TextInputType> emailTextInputTypes = [
    TextInputType.emailAddress,
    TextInputType.multiline
  ];

  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TextStyle headingTextStyle = TextStyle(
        color: kFontColor,
        fontWeight: FontWeight.bold,
        fontSize: screenHeight * 0.035);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to ',
                  style: GoogleFonts.lora(
                    textStyle: headingTextStyle,
                    height: 1,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: screenHeight * 0.045,
                    letterSpacing: -1.5,
                  ),
                ),
                Text(
                  'coin',
                  style: TextStyle(
                    height: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: screenHeight * 0.045,
                    letterSpacing: -1.5,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(0, 0),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
                Text(
                  'eye',
                  style: TextStyle(
                    height: 1,
                    color: Color(0xFF2BFFF1),
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(0, 0),
                        blurRadius: 5,
                      ),
                    ],
                    fontWeight: FontWeight.w900,
                    fontSize: screenHeight * 0.045,
                    letterSpacing: -1.5,
                  ),
                ),
                Text(
                  ' !',
                  style: GoogleFonts.lora(
                    textStyle: headingTextStyle,
                    height: 1,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: screenHeight * 0.045,
                    letterSpacing: -1.5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Text(
              'Please sign up with your phone number',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: kFontColor, fontSize: screenHeight * 0.019),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            InputTextField(
              prefixIcon: Container(
                width: screenHeight * 0.105,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenHeight * 0.007,
                    ),
                    Image.asset(
                      'images/indian-flag.png',
                      height: screenHeight * 0.025,
                    ),
                    SizedBox(
                      width: screenHeight * 0.005,
                    ),
                    Text(
                      '+91',
                      style: TextStyle(
                          color: kHintTextColor,
                          fontSize: screenHeight * 0.02,
                          height: screenHeight * 0.0013),
                    ),
                    SizedBox(
                      width: screenHeight * 0.005,
                    ),
                    Container(
                      height: screenHeight * 0.035,
                      width: screenHeight * 0.001,
                      color: kHintTextColor,
                    ),
                  ],
                ),
              ),
              screenHeight: screenHeight,
              keyboardType: TextInputType.phone,
              hintText: 'Phone Number',
              cursorColor: kFontColor,
              textColor: kFontColor,
              hintTextColor: kHintTextColor,
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            RoundedButton(
              color: kCyan,
              shadowColor: Color.fromRGBO(153, 153, 153, 0.1),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.02,
                  letterSpacing: screenHeight * 0.0005,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OTPVerification(phoneNumber);
                }));
              },
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: screenHeight * 0.012,
                    child: Divider(
                      height: 0,
                      color: kBorderColor,
                      thickness: screenHeight * 0.001,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.01),
                  child: Text(
                    'OR',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.021),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: screenHeight * 0.012,
                    child: Divider(
                      height: 0,
                      color: kBorderColor,
                      thickness: screenHeight * 0.001,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.022,
            ),
            RoundedButton(
              bordered: true,
              color: kLightCyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/metamask_logo.png',
                    width: screenHeight * 0.027,
                  ),
                  Text(
                    '  Connect to',
                    style: TextStyle(color: kFontColor),
                  ),
                  Text(
                    ' Metamask',
                    style: TextStyle(
                        color: kFontColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            RoundedButton(
              bordered: true,
              color: kLightCyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/google_logo.png',
                    width: screenHeight * 0.025,
                  ),
                  Text(
                    '  Connect to',
                    style: TextStyle(color: kFontColor),
                  ),
                  Text(
                    ' Google',
                    style: TextStyle(
                        color: kFontColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            RoundedButton(
              color: kAppleBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/apple_logo.png',
                    width: screenHeight * 0.027,
                  ),
                  Text(
                    '  Connect to',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    ' Apple',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: kFontColor),
                ),
                GestureDetector(
                  child: Text(
                    ' SignIn',
                    style: TextStyle(color: kCyan, fontWeight: FontWeight.bold),
                  ),
                  onTap: widget.onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
