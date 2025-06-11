import 'package:flutter/material.dart';
import 'package:food_app/screens/order_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
class IntoductionScreenWidget extends StatelessWidget {
  IntoductionScreenWidget({super.key});
  final List<PageViewModel> listofintropage = [
    PageViewModel(
        titleWidget: Column(
          children: [
            Text(
              "We are at you door.",
              style:
                  GoogleFonts.urbanist(fontSize: 26, fontWeight: FontWeight.w700),
            ),
            
          ],
        ),
        bodyWidget: Image(image: AssetImage("asset/icons/icon.png")),
        decoration: PageDecoration(
          pageColor: Colors.white,
          bodyAlignment: Alignment.center,
        )
        ),
    PageViewModel(
        titleWidget: Text(
          "Traditional Foods",
          style:
              GoogleFonts.urbanist(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        bodyWidget: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/Gomen Kitfo.JPG"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          bodyAlignment: Alignment.center,
        )),
    PageViewModel(
        titleWidget: Text("Breads",
            style: GoogleFonts.urbanist(
                fontSize: 26, fontWeight: FontWeight.w700)),
        bodyWidget: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/Dintch.JPG"), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        decoration: PageDecoration(
            pageColor: Colors.white, bodyAlignment: Alignment.center)),
    PageViewModel(
        titleWidget: Text("Fast Foods",
            style: GoogleFonts.urbanist(
                fontSize: 26, fontWeight: FontWeight.w700)),
        bodyWidget: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/Beyaynet.JPG"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        decoration: PageDecoration(
            pageColor: Colors.white, bodyAlignment: Alignment.center)),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listofintropage,
      done: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OrderScreen()));
        },
        child: Container(
          width: 150,
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "order",
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
      showNextButton: false,
      onDone: () {},
    );
  }
}
