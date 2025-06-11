import 'package:flutter/material.dart';
import 'package:food_app/provider/credintial_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/screens/login_screen.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  bool _passwordInvisible = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void _signUp() async {
    // Check if passwords match
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
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
          content: Text("Password do not match!")),
      );
      return;
    }

    try {
      Provider.of<CredintialProvider>(context, listen: false)
          .signUp(emailController.text, passwordController.text,usernameController.text, context);
      
    } catch (e) {
      // Handle sign-up error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign Up failed: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Account',
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Sign up to get started',
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Username input
                TextField(
                  controller: usernameController,
                  style: GoogleFonts.urbanist(),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: GoogleFonts.urbanist(color: primaryColor),
                    prefixIcon: const Icon(Icons.person, color: primaryColor),
                    filled: true,
                    fillColor: Colors.deepPurple[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Email input
                TextField(
                  controller: emailController,
                  style: GoogleFonts.urbanist(),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: GoogleFonts.urbanist(color: primaryColor),
                    prefixIcon: const Icon(Icons.email, color: primaryColor),
                    filled: true,
                    fillColor: Colors.deepPurple[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Password input
                TextField(
                  controller: passwordController,
                  obscureText: _passwordInvisible,
                  style: GoogleFonts.urbanist(),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.urbanist(color: primaryColor),
                    prefixIcon: const Icon(Icons.lock, color: primaryColor),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordInvisible = !_passwordInvisible;
                          });
                        },
                        child: Icon(
                          _passwordInvisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: primaryColor,
                        )),
                    filled: true,
                    fillColor: Colors.deepPurple[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Confirm password input
                TextField(
                  controller: confirmPasswordController,
                  obscureText: _passwordInvisible,
                  style: GoogleFonts.urbanist(),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.urbanist(color: primaryColor),
                    prefixIcon: const Icon(Icons.lock, color: primaryColor),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordInvisible = !_passwordInvisible;
                          });
                        },
                        child: Icon(
                          _passwordInvisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: primaryColor,
                        )),
                    filled: true,
                    fillColor: Colors.deepPurple[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Sign Up button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'Already have an account? Log in',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
