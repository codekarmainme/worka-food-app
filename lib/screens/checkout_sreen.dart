import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/constants/common.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/widgets/text_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/model/order.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/screens/login_screen.dart';

class CheckoutSreen extends StatefulWidget {
  const CheckoutSreen({super.key,required this.deliveryAddress});
  final String deliveryAddress;
  @override
  State<CheckoutSreen> createState() => _CheckoutSreenState();
}

class _CheckoutSreenState extends State<CheckoutSreen> {
  // Controllers for text fields
  final _auth=FirebaseAuth.instance;
  String? email;
  
  @override
  void initState() {
    super.initState();
    email = _auth.currentUser?.email;
    emailController.text = email ?? "No email available";
    addressController.text=widget.deliveryAddress;
  }
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(); // New Controller
  num orderno = 01;
  final _formKey = GlobalKey<FormState>();
  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Enter only letters";
    }
    return null;
  }
    String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Address can't be empty";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    } else if (!RegExp(r'^[\w-]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$')
        .hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "Phone number can't be empty";
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }
    User? user = FirebaseAuth.instance.currentUser;

  Future<void> postOrderToFirestore(CartProvider cartProvider) async {
    orderno = Timestamp.now().microsecondsSinceEpoch;
   
    // validation

    if (user != null) {
      String uid = user!.uid;
      try {
        // Create an Order object
        OrderItem order = OrderItem(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          address: addressController.text,
          phoneNumber: phoneNumberController.text,
          email: emailController.text,
          cartItems: cartProvider.food_oncart, // Use the items in the cart
          totalAmount: cartProvider.totalbill() + 70,
          orderTime: Timestamp.now(),
          orderno: Timestamp.now().microsecondsSinceEpoch,
          uid: uid,
          // Record the current time
        );

        // Post the order to Firestore
        await FirebaseFirestore.instance
            .collection('orders')
            .add(order.toMap());

        // Show success message
        showSuccessToast("Order placed successfully!");
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ));
      } catch (e) {
        print("Error posting order: $e");
        showErrorToast("Failed to place the order. Please try again.");
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    emailController.dispose(); // Dispose new controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access CartProvider
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add padding for better UI
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to start
              children: [
                // Display Cart Items
                Text(
                  "Your Cart",
                  style: GoogleFonts.urbanist(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                cartProvider.food_oncart.isEmpty
                    ? Text(
                        "Your cart is empty.",
                        style: GoogleFonts.urbanist(),
                      )
                    : SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        child: ListView.builder(
                            shrinkWrap: true,
                            
                            itemCount: cartProvider.food_oncart.length,
                            itemBuilder: (context, index) {
                              final item = cartProvider.food_oncart[index];
                              return ListTile(
                                leading: Icon(FontAwesomeIcons.utensils,
                                    color: primaryColor),
                                title: Text(item.name,
                                    style: GoogleFonts.urbanist(fontSize: 16)),
                                subtitle: Text(
                                  "Quantity: ${item.quantity}",
                                  style: GoogleFonts.urbanist(fontSize: 16),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "ETB ${item.price * item.quantity}",
                                      style: GoogleFonts.urbanist(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Delivey Fee',
                      style: GoogleFonts.urbanist(fontSize: 16),
                    ),
                    Text(
                      'ETB 70',
                      style: GoogleFonts.urbanist(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Display Total Bill
                Text(
                  "Total: ETB ${cartProvider.totalbill() + 70}",
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const Divider(height: 30, thickness: 2),
                // User Information Fields

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: firstNameController,
                        hintText: "First Name",
                        icon: FontAwesomeIcons.person,
                        validator: (value) => validateName(value!),
                      ),
                      TextFieldWidget(
                        controller: lastNameController,
                        hintText: "Last Name",
                        icon: FontAwesomeIcons.person,
                        validator: (value) => validateName(value!),
                      ),
                      TextFieldWidget(
                        controller: emailController, // Add email field
                        hintText: "Email",
                        icon: FontAwesomeIcons.envelope,
                        validator: (value) => validateEmail(value!),
                      ),
                      TextFieldWidget(
                        controller: addressController,
                        hintText: "Address",
                        icon: FontAwesomeIcons.mapLocation,
                        validator: (value) => validateAddress(value!),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: IntlPhoneField(
                          // Attach the controller
                          style: GoogleFonts.urbanist(),
                          validator: (value) =>
                              validatePhoneNumber(value!.toString()),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: GoogleFonts.urbanist(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'ET',
                          onChanged: (phone) {
                            phoneNumberController.text =
                                phone.completeNumber; // Update controller
                            print("Phone Number: ${phone.completeNumber}");
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                // Place Order Button
                SizedBox(
                  width: double.infinity, // Make button full width
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, proceed with order submission
                        postOrderToFirestore(cartProvider);
                      } else {
                        // Display an error message if validation fails
                        showErrorToast(
                            "Please correct the errors in the form.");
                      }
                    },
                    child: Text(
                      "Place Order",
                      style: GoogleFonts.urbanist(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
