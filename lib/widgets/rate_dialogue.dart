import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateDialog extends StatefulWidget {
   RateDialog({super.key,required this.date,required this.deliveryGuy,required this.orderno});
  final num orderno;
  final String date;
  String deliveryGuy;
  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  String reviewText = '';
  String ratingValue = '3';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(  // Wrap the Column with SingleChildScrollView to prevent overflow
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person_2),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.date,
                          style: GoogleFonts.ubuntu(
                              color: secondaryColor, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.deliveryGuy,
                          style: GoogleFonts.ubuntu(
                              color: secondaryColor, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "order #${widget.orderno}",
                          style: GoogleFonts.ubuntu(
                              color: secondaryColor, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Text(
                "How was the food and service?",
                style: GoogleFonts.ubuntu(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rate your experience",
                style: GoogleFonts.ubuntu(),
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: primaryColor,
                  size: 5,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    ratingValue = rating.toString();
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Review",
                      style: GoogleFonts.ubuntu(),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  
                  onChanged: (value) {
                    setState(() {
                      reviewText = value;
                    });
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  style: GoogleFonts.ubuntu(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.ubuntu(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
