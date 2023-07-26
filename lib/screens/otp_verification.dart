import 'dart:async';

import 'package:coin_eye/services/firebase_phone_auth.dart';
import 'package:coin_eye/utilities/constants.dart';
import 'package:coin_eye/utilities/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'price_screen.dart';

class OTPVerification extends StatefulWidget {
  final String phoneNumber;

  OTPVerification(this.phoneNumber);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  int? resendOTPGap;
  String otp = '';
  String? buttonText;
  TextEditingController? otpController;
  FirebasePhoneAuth? firebasePhoneAuth;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? userCredential;

  @override
  void initState() {
    buttonText = 'Resend OTP';
    otpController = TextEditingController();
    startResendOTPTimer();
    triggerFirebaseAuthVerification();
    super.initState();
  }

  @override
  void dispose() {
    otpController!.dispose();
    super.dispose();
  }

  Widget? bottomHelperOptions(screenHeight) {
    if (buttonText == 'Done') {
      return Column(
        children: [
          Text(
            'Didn\'t receive any code?',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          GestureDetector(
            child: Text(
              'Re-send Code',
              style: TextStyle(color: kBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    } else {
      return null;
    }
  }

  void startResendOTPTimer() async {
    resendOTPGap = 30;
    while (resendOTPGap != 0) {
      await Future.delayed(
        Duration(seconds: 1),
        () {},
      );
      setState(() {
        resendOTPGap = resendOTPGap! - 1;
      });
    }
  }

  void triggerFirebaseAuthVerification() async {
    await Future.sync(() {
      firebasePhoneAuth = FirebasePhoneAuth(
        context: context,
        otpController: otpController,
        otpCode: (value) {
          setState(() {
            otp = value;
          });
        },
      );
    });
    await firebasePhoneAuth!.phoneSignIn(widget.phoneNumber);
    int flag = 1; //So that it listens only once for one call of this function
    _auth.authStateChanges().listen((user) {
      if (user != null && flag == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PriceScreen(),
          ),
        );
        flag = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TextStyle headingTextStyle =
        TextStyle(color: kFontColor, fontSize: screenHeight * 0.03);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 4,
        toolbarHeight: screenHeight * 0.07,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.elliptical(screenHeight * 0.9, screenHeight * 0.1),
        //   ),
        // ),
        backgroundColor: Colors.black,
        leadingWidth: 0,
        leading: SizedBox(
          height: 0,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'coin',
              style: TextStyle(
                height: 1,
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: screenHeight * 0.05,
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
                color: kBlue,
                shadows: <Shadow>[
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(0, 0),
                    blurRadius: 5,
                  ),
                ],
                fontWeight: FontWeight.w200,
                fontSize: screenHeight * 0.05,
                letterSpacing: -1.5,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.025, vertical: screenHeight * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Text(
                'Please verify your phone number',
                textAlign: TextAlign.center,
                style: headingTextStyle,
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                'A six digit code has been sent to +91 ${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kFontColor,
                  fontSize: screenHeight * 0.019,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Incorrect number? ',
                    style: TextStyle(
                        color: kFontColor, fontSize: screenHeight * 0.019),
                  ),
                  GestureDetector(
                    child: Text(
                      ' Change',
                      style:
                          TextStyle(color: kBlue, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.14,
              ),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  colorBuilder: FixedColorBuilder(Colors.black),
                  textStyle: TextStyle(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                controller: otpController,
                currentCode: otp,
                onCodeChanged: (code) {
                  setState(() {
                    otp = code!;
                  });
                  if (code!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      buttonText = 'Done';
                    });
                  } else {
                    setState(() {
                      buttonText = 'Resend OTP';
                    });
                  }
                },
                codeLength: 6,
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              RoundedButton(
                color: (resendOTPGap == 0 || buttonText == 'Done')
                    ? kBlue
                    : kLightBlue,
                shadowColor: (resendOTPGap == 0 || buttonText == 'Done')
                    ? Color.fromRGBO(153, 153, 153, 0.1)
                    : Color.fromRGBO(153, 153, 153, 0),
                child: Text(
                  buttonText!,
                  style: TextStyle(
                    color: (resendOTPGap == 0 || buttonText == 'Done')
                        ? kFontColor
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.02,
                    letterSpacing: screenHeight * 0.0005,
                  ),
                ),
                onPressed: () async {
                  if (buttonText == 'Done') {
                  } else if (buttonText == 'Resend OTP' && resendOTPGap == 0) {
                    initState();
                  }
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                child: (resendOTPGap != 0)
                    ? Text(
                        'Resend OTP in ${resendOTPGap}s',
                        textAlign: TextAlign.center,
                      )
                    : bottomHelperOptions(screenHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
