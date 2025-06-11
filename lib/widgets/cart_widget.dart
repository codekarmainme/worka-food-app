import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/cart_provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget(
      {required this.amount,
      required this.imageUrl,
      required this.price,
      required this.name});
  final String amount, imageUrl, price, name;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Row(
          children: [
            IconButton(
              onPressed: (){
                cartProvider.decreaseQuantity(name);
              },
              icon: FaIcon(FontAwesomeIcons.minus)),
              IconButton(
                onPressed: (){
                  cartProvider.increaseQuantity(name);
                },
                icon: FaIcon(FontAwesomeIcons.add)),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: AssetImage(imageUrl), fit: BoxFit.cover),
                  ),
                ),
                Text(amount + ' X ' + price,
                    style: GoogleFonts.urbanist(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: (){
                cartProvider.removeItem(name);
              },
              icon: FaIcon(FontAwesomeIcons.multiply)),
          ],
        );
      },
    );
  }
}
