import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/widgets/review_container.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewHistoryScreen extends StatelessWidget {
  const ReviewHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text("My Reviews",
                style: GoogleFonts.urbanist(color: Colors.black)),
          ),
          backgroundColor: Colors.white
        ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            ReviewContainer()
          ],
        )
      ));
  }
}