import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: secondaryColor,
              child:Icon(Icons.person,color: Colors.white,size: 50)
            ),
            SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text("09/31/24",style:GoogleFonts.urbanist()),
                  Text("Amazing Service",style:GoogleFonts.urbanist(fontSize: 20,fontWeight: FontWeight.bold)),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text("The food was greet.The service was amazing and fast deleivery",style: GoogleFonts.urbanist(color:secondaryColor))),
            
                  Row(
                    children: [
                      Icon(Icons.star,color: primaryColor,),
                       Icon(Icons.star ,color: primaryColor,),
                        Icon(Icons.star,color: primaryColor,),
                         Icon(Icons.star,color:primaryColor,),
                          Icon(Icons.star_half,color:primaryColor,)
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}