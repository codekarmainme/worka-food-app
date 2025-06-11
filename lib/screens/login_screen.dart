import 'package:flutter/material.dart';
import 'package:food_app/provider/credintial_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/screens/signup_screen.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
   bool islogging=false;
   bool _passwordInisible=true;
  void _login() async {
    try {
      islogging=true;
        Provider.of<CredintialProvider>(context,listen:false).signIn(emailController.text, passwordController.text,context);
      islogging=false;
      
    } catch (e) {
      // Handle error (e.g., show a dialog or a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor.withOpacity(0.5),
          content: Text("Something went wrong",style: GoogleFonts.urbanist(),)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50], // Light background to match style
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Text(
                  "Login",
                  style: GoogleFonts.urbanist(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primaryColor, // Primary Dark color
                  ),
                ),
                
                const SizedBox(height: 40),

                // Email Field
                TextField(
                  controller: emailController,
                  style: GoogleFonts.urbanist(),
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email, color:primaryColor),
                    filled: true,
                    fillColor: Colors.deepPurple[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                TextField(
                  controller: passwordController,
                  style: GoogleFonts.urbanist(),
                  obscureText: _passwordInisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          _passwordInisible=!_passwordInisible;
                        });
                      },
                      child: Icon(_passwordInisible?Icons.visibility_off:Icons.visibility,color: primaryColor,)),
                    filled: true,
                    fillColor: Colors.deepPurple[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: islogging ? null:_login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sign up prompt
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    "Don't have an account? Sign up",
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
