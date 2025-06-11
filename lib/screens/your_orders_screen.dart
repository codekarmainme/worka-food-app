import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/widgets/order_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class YourOrdersScreen extends StatefulWidget {
  @override
  State<YourOrdersScreen> createState() => _YourOrdersScreenState();
}

class _YourOrdersScreenState extends State<YourOrdersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedStatus = 'All';
  Stream<QuerySnapshot> getOrdersStream() {
    if (_selectedStatus == "All") {
      return _firestore
          .collection('orders')
          .where('uid', isEqualTo: _auth.currentUser?.uid)
          .snapshots();
    } else if (_selectedStatus == "Pending") {
      return _firestore
          .collection('orders')
          .where('uid', isEqualTo: _auth.currentUser?.uid)
          .where('delivered', isEqualTo: false)
          .snapshots();
    } else if (_selectedStatus == "Completed") {
      return _firestore
          .collection('orders')
          .where('uid', isEqualTo: _auth.currentUser?.uid)
          .where('delivered', isEqualTo: true)
          .snapshots();
    } else {
      return _firestore
          .collection('orders')
          .where('uid', isEqualTo: _auth.currentUser?.uid)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          ),
          title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("My Orders",
                  style: GoogleFonts.urbanist(color: Colors.black))),
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width * 0.5,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryColor, width: 1),
                ),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _selectedStatus,
                      style: GoogleFonts.urbanist(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Colors.white,
                      elevation: 0,
                      items: [
                        DropdownMenuItem(
                          value: "All",
                          child: Text("All"),
                        ),
                        DropdownMenuItem(
                          value: "Pending",
                          child: Text("Pending"),
                        ),
                        DropdownMenuItem(
                          value: "Completed",
                          child: Text("Completed"),
                        ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          _selectedStatus = newValue.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: StreamBuilder<QuerySnapshot>(
                  stream: getOrdersStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _ordersShimmer();
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width*0.9,
                        decoration:BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:primaryColor,width: 1)
                        ),
                        child: Center(child: Column(
                          children: [
                            Icon(Icons.shopping_bag_outlined,size:40,color:secondaryColor),
                            Text('No orders found!',style:GoogleFonts.urbanist(fontSize: 30,color:secondaryColor)),
                          ],
                        ))));
                    }
        
                    final orders = snapshot.data!.docs;
                    
                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final orderData = order.data() as Map<String, dynamic>;
        
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
        
                              child: OrderContainer(
                                  iscompletedorder: orderData['delivered'],
                                  foodname: orderData["cartItems"][0]['name'],
                                  imageurl: orderData["cartItems"][0]['imageUrl'],
                                  orderno: orderData['orderno'],
                                  ordertime: orderData['orderTime'],
                                  quantity: orderData["cartItems"].length,
                                  totalAmount: orderData['totalAmount'])),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ordersShimmer() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10))
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 60,
                          height: 20,
                           decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10))
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 50,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10))),
                        SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 10,
                           decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10))),
                        
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 20,
                       decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10))
                    ),
                    Container(
                      width: 100,
                      height: 20,
                       decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10))
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey[300]!, width: 2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
