import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/constants/app_colors.dart';

class CatagoryButtons extends StatelessWidget {
  const CatagoryButtons({super.key,required this.btnColor,required this.title,required this.setCatagory});
  final String title;
  final Color btnColor;
  final VoidCallback  setCatagory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: setCatagory,
      child: Container(
        width: MediaQuery.of(context).size.width*0.3,
        height: 20,
         child: Center(child: Padding(
           padding: const EdgeInsets.all(4.0),
           child: Text(title,style: GoogleFonts.urbanist(color:secondaryColor),),
         )),
         decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1,color: Colors.green)
         ),
      ),
    );
  }
}