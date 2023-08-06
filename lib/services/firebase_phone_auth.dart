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
        await _auth.signInWithCredential(credential);
        _auth.authStateChanges().listen((user) {
          if (user != null) {
            otp = credential.smsCode!;
            otpCode = (otp) {};
          } else {
            print('User Logged Out');
          }
        });
      },
      verificationFailed: (e) {
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text(e.code, style: TextStyle(color: Colors.red)),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 5),
          ),
        );
      },
      codeSent: (verificationId, resendToken) async {
        PhoneAuthCredential credential;
        otpController!.addListener(() async {
          if (otpController!.text.trim().length == 6) {
            credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otpController!.text.trim(),
            );
            await _auth.signInWithCredential(credential);
          }
        });
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (verificationId) {
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
