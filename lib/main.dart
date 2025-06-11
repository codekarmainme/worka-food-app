import 'package:flutter/material.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/provider/credintial_provider.dart';
import 'package:food_app/provider/location_provider.dart';
import 'package:food_app/screens/IntroductionScreenpage.dart';
import 'package:food_app/screens/paymentfallback.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/constants/stripe_keys.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    name: "food_app", 
    options: FirebaseOptions(
    apiKey: 'key',
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: 'myapp',
    storageBucket: 'myapp-b9yt18.appspot.com',)); 
    await _setupStripe();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>CartProvider()),
     ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => CredintialProvider()),
  ],
  child: MyApp(),
  ) );
}
Future<void> _setupStripe()async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=publishkey;
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/route': (context) => PaymentFallback(), // Payment fallback screen
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreenpage());
  }
}
