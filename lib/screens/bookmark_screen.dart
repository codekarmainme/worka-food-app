import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

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
              child: Text("Bookmarks",
                  style: GoogleFonts.urbanist(color: Colors.black))),
          backgroundColor: Colors.white
          
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.45,
                    decoration: BoxDecoration(
                       border: Border.all(color: Colors.black,width: 2),
                       borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.bookmark,size: 25,color: primaryColor,),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.25,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("lib/assets/product_09.jpg"))
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Chicken Burger",style: GoogleFonts.urbanist(),),
                            Text("ETB 220",style: GoogleFonts.urbanist(),)
                          ],
                        ),
                        SizedBox(height:10),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Add to cart",style: GoogleFonts.urbanist(color: Colors.white),
                            
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                ],
              ),
            )
            ,
          ),
    );
  }
}
