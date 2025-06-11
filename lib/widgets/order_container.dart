import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/widgets/rate_dialogue.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:food_app/screens/track_order_screen.dart';
import 'package:food_app/widgets/cancle_order_dialogue.dart';

class OrderContainer extends StatelessWidget {
  const OrderContainer(
      {super.key,
      required this.iscompletedorder,
      required this.foodname,
      required this.imageurl,
      required this.orderno,
      required this.ordertime,
      required this.quantity,
      required this.totalAmount});
  final bool iscompletedorder;
  final Timestamp ordertime;
  final String foodname;
  final String imageurl;
  final num orderno;
  final num quantity;
  final num totalAmount;
  @override
  Widget build(BuildContext context) {
    DateTime orderDateTime =
        ordertime.toDate(); // Convert Timestamp to DateTime
    String formattedDate = DateFormat('MMMM d')
        .format(orderDateTime); // Format DateTime to "October 24"

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(imageurl), fit: BoxFit.cover)),
              ),
              SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(foodname,
                        style:
                            GoogleFonts.urbanist(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("ETB ${totalAmount.toString()}",
                        style: GoogleFonts.urbanist())
                  ]
                  //name and total price container
                  ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("#$orderno".toString(),
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.bold, color: secondaryColor)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(formattedDate,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.bold, color: secondaryColor))
                ],
                //order no and date container
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${quantity.toString()} items",
                  style: GoogleFonts.urbanist(fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  iscompletedorder ? "Completed" : "Ongoing",
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w900,
                      color: iscompletedorder
                          ? Color.fromRGBO(84, 186, 84, 0.612)
                          : counterbtnColor),
                ),
              )
            ],
            //no of item and and status container
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrackOrderScreen(
                                orderId: orderno,
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 40,
                  child: Center(
                    child: Text(
                      iscompletedorder ? "Re-Order" : "Track order",
                      style: GoogleFonts.urbanist(color: secondaryColor),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              GestureDetector(
                onTap: () {
                 iscompletedorder?showDialog(
                      context: context,
                      builder: (context) => RateDialog(
                            date: formattedDate,
                            deliveryGuy: "Abekel Bekele",
                            orderno: orderno,
                          )): showDialog(
                      context: context,
                      builder: (context) => CancelOrderDialog(
                            onConfirm: () {},
                            context: context,
                            orderno: orderno,
                          ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 40,
                  child: Center(
                    child: Text(
                      iscompletedorder ? "Rate" : "Cancle",
                      style: GoogleFonts.urbanist(color: primaryColor),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 100),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: primaryColor, width: 2)),
                ),
              )
            ],
            //buttons container
          )
        ],
      ),
    );
  }
}
