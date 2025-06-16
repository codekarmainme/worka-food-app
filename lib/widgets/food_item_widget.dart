import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/screens/food_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/model/food_oncart.dart';
import 'package:food_app/constants/app_colors.dart';
// ...existing imports...

class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.ingredients,
  });

  final String imageUrl, name;
  final num price;
  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 40), // Add space for the image overflow

      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            'ETB ${price.toString()}',
                            style: GoogleFonts.urbanist(color: secondaryColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.green,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text('4.5', style: GoogleFonts.urbanist())
                            ],
                          )
                        ],
                      ),
                      Text(
                        '1 km',
                        style: GoogleFonts.urbanist(color: secondaryColor),
                      )
                    ],
                  ),
                  Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                    return TextButton(
                      onPressed: () {
                        cartProvider.addTocart(FoodOnCartItem(
                            name: name,
                            imageUrl: imageUrl,
                            price: price,
                            quantity: 1));
                      },
                      child: Text(
                        "Add to Cart",
                        style: GoogleFonts.urbanist(
                            fontSize: 16, color: primaryColor),
                        textAlign: TextAlign.center,
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Positioned(
            top: -40, // Half out of the card
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodDetailScreen(
                              imageUrl: imageUrl,
                              ingredients: ingredients,
                              foodName: name,
                              price: price,
                            )));
              },
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(imageUrl), fit: BoxFit.cover),
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
