import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebasePhoneAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final BuildContext? context;
  static String? codeVerificationId;
  int? resendToken;
  final TextEditingController? otpController;

  Function(String)? otpCode;

  FirebasePhoneAuth({
    @required this.context,
    @required this.otpController,
    this.otpCode,
  });

  Future phoneSignIn(String phoneNumber) async {
    String otp;
    UserCredential userCredential;
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (credential) async {
        try {
          await _auth.signInWithCredential(credential);
          _auth.authStateChanges().listen((user) {
            if (user != null) {
              otp = credential.smsCode!;
              otpCode = (otp) {};
            } else {
              print('User Logged Out');
            }
          });
        } catch (e) {
          print(e.toString());
        }
      },
      verificationFailed: (e) {
        print(e.toString());
      },
      codeSent: (verificationId, resendToken) async {
        PhoneAuthCredential credential;
        otpController!.addListener(() async {
          if (otpController!.text.trim().length == 6) {
            // try {
              credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: otpController!.text.trim(),
              );
            // } catch (e) {
            //   print(e.toString());
            // }
            try {
              await _auth.signInWithCredential(credential);
            } catch (e) {
              print(e.toString());
            }
          }
        });
      },
      codeAutoRetrievalTimeout: (value) {
        if (_auth.currentUser == null) {
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              content: Text(
                  'Unable to automatically read the code. Please enter it manually.',
                  style: TextStyle(color: Colors.red)),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
    );
    // return userCredential;
  }
}
