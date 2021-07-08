import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:idreamcare/feature/authentication/screens/otpscreen/otp_screen.dart';
import 'package:idreamcare/feature/authentication/screens/phoneauth/firebasedb/firebase_db.dart';
import 'package:idreamcare/feature/presentation/screens/homescreen/home_Screen.dart';

class PhoneAuthentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String? phoneNumber;
  FirebaseRepository appUser = FirebaseRepository();
  TextEditingController codeController = TextEditingController();

  Future<void> loginUser(String? phoneNumber, BuildContext context) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber!,
      timeout: Duration(seconds: 45),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        UserCredential result = await auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Homescreen(),
            ),
          );
        } else {
          print("error");
        }
        appUser.setData(phoneNumber);
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verifcationId, [int? forceCodeSentToken]) {
        print(verifcationId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                      contactNumber: phoneNumber,
                      verificationUSerId: verifcationId,
                    )));
      },
      codeAutoRetrievalTimeout: (
        String verifcationId,
      ) {
        print(verifcationId);
      },
    );
  }

  Future<void> logOutUser() async {
    await auth.signOut();
  }
}
