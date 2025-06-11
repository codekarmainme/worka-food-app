
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CredintialProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      Navigator.pop(context);
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          closeIconColor: Colors.white,
          action: SnackBarAction(label: "X", 
          textColor: Colors.white,
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
            backgroundColor: primaryColor.withOpacity(1),
            content: Text(
              "Something went wrong",
              style: GoogleFonts.urbanist(),
            )),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> signUp(
      String email, String password,String username, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(_user!.uid).set(
        {
          'email':_user!.email,
          'uid':_user!.uid,
          "username":username
        }
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      await sendEmailVerification();
      notifyListeners();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          closeIconColor: Colors.white,
          action: SnackBarAction(label: "X", 
          textColor: Colors.white,
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
            backgroundColor: primaryColor.withOpacity(1),
          content: Text("Sign Up failed: Something went wrong")),
      );
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      if (_user != null && !_user!.emailVerified) {
        await _user!.sendEmailVerification();
      }
    } catch (e) {
      print('Error sending email verification: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error resetting password: $e');
    }
  }

  Future<void> reloadUser() async {
    try {
      if (_user != null) {
        await _user!.reload();
        _user = _auth.currentUser;
        notifyListeners();
      }
    } catch (e) {
      print('Error reloading user: $e');
    }
  }
}
