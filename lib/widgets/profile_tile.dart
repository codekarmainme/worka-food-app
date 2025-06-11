import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.icon,required this.name,required this.navigateto});
 final IconData icon;
 final String name;
 final VoidCallback navigateto;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:navigateto,
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon,color:primaryColor,),
            Text(name,style: GoogleFonts.urbanist(),),
            Icon(Icons.arrow_forward_ios_rounded,color: secondaryColor,)
          ],
        ),
      ),
    );
  }
}