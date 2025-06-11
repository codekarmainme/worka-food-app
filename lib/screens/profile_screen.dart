import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/provider/credintial_provider.dart';
import 'package:food_app/screens/bookmark_screen.dart';
import 'package:food_app/screens/order_screen.dart';
import 'package:food_app/screens/review_history_screen.dart';
import 'package:food_app/screens/your_orders_screen.dart';
import 'package:food_app/widgets/profile_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import  'package:provider/provider.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool pfseen=false;
  void setPFseen(){
    setState(() {
      pfseen=!pfseen;
    });
    
  }
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
              color: Colors.white,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text("My Profile",
                style: GoogleFonts.urbanist(color: Colors.white)),
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Number of Orders",
                          style: GoogleFonts.urbanist(
                              color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "7 Orders",
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap:(){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: Colors.white)),
                            child: Center(
                                child: Text(
                              "Order",
                              style: GoogleFonts.urbanist(
                                  color: Colors.white, fontSize: 20),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(30, 220, 223, 223),
                    ),
                    child: GestureDetector(
                      onTap: setPFseen,
                      child: Padding(
                        padding: const EdgeInsets.only(top:12.0,bottom:12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                ),
                                Text(
                                  "Personal information",
                                  style: GoogleFonts.urbanist(),
                                ),
                                Icon(
                                 pfseen?Icons.arrow_downward:Icons.arrow_forward_ios_rounded,
                                  color: secondaryColor,
                                )
                              ],
                            ),
                           if(pfseen) Text("Joe bere",style: GoogleFonts.urbanist(),),
                            if(pfseen) Text("xxx@gmail.com",style: GoogleFonts.urbanist())
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(30, 220, 223, 223),
                    ),
                    child: Column(
                      children: [
                        ProfileTile(
                          icon: Icons.shopping_bag_outlined,
                          name: "Orders",
                          navigateto:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>YourOrdersScreen()));
                          } ,
                        ),
                        ProfileTile(
                          icon: FontAwesomeIcons.star,
                          name: "Reviews",
                           navigateto:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewHistoryScreen()));

                           } ,
                        )
                      ],
                    ),
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(30, 220, 223, 223),
                    ),
                   child: Column(
                      children: [
                        ProfileTile(
                          icon: FontAwesomeIcons.bookmark,
                          name: "Bookmarks",
                           navigateto:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookmarkScreen()));
                           } ,
                        ),
                        ProfileTile(
                          icon:Icons.logout,
                          name: "Logout",
                           navigateto:(){
                            Provider.of<CredintialProvider>(context,listen:false).signOut();
                            Navigator.pop(context);
                           } ,
                        )
                      ],
                    ),
                    )
                ],
              )),
        ));
  }
}
