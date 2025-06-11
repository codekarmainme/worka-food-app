import 'package:flutter/material.dart';
import 'package:food_app/screens/food_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/widgets/food_dialogue_widget.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/model/food_oncart.dart';
import 'package:food_app/constants/app_colors.dart';
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
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetailScreen(imageUrl: imageUrl,ingredients: ingredients,foodName: name,price: price,)));
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => FoodDialogWidget(
                  //     imageUrl: imageUrl,
                  //     name: name,
                  //     price: price,
                  //     ingredients: ingredients,
                  //   ),
                  // );
                },
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Text(
              name,
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w900),
            ),
            Text(
              'ETB ${price.toString()}',
              style: GoogleFonts.urbanist(color: secondaryColor),
            ),
           Consumer<CartProvider>(builder: (context,cartProvider,child){
            return ElevatedButton(
                           onPressed: (){
                           cartProvider.addTocart(FoodOnCartItem(name: name, imageUrl: imageUrl, price: price, quantity: 1));
                           },
                            child: Text(
                              "Add to Cart",
                              style: GoogleFonts.urbanist(fontSize: 16,color:Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              
                            ),
                           
                          );
           }
           
           )
          ],
        ),
      ),
    );
  }
}
