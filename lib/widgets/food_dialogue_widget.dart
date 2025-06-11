import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/model/food_oncart.dart';
class FoodDialogWidget extends StatefulWidget {
  final String imageUrl, name;
  final num price;
  final List<String> ingredients;

  FoodDialogWidget({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.ingredients,
  });

  @override
  _FoodDialogWidgetState createState() => _FoodDialogWidgetState();
}

class _FoodDialogWidgetState extends State<FoodDialogWidget> {
  int quantity = 1; 

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(child: Image.asset(widget.imageUrl, fit: BoxFit.cover, width: double.infinity,height:MediaQuery.of(context).size.height*0.3)),
            SizedBox(height: 10),
            Text(
              widget.name,
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w900, fontSize: 22),
            ),
            SizedBox(height: 10),
            Text(
              'Price: Br.${widget.price.toString()}',
              style: GoogleFonts.urbanist(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Ingredient Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingredients:',
                  style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      quantity.toString(),
                      style: GoogleFonts.urbanist(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
            // Display ingredients list
            for (var ingredient in widget.ingredients)
              Text(
                ingredient,
                style: GoogleFonts.urbanist(fontSize: 16),
              ),
            SizedBox(height: 20),
            // Add to Cart Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    maximumSize: Size(150,50)
                  ),
                  onPressed: () {
                    // Add food to cart using CartProvider
                    Provider.of<CartProvider>(context, listen: false).addTocart(
                   FoodOnCartItem(name: widget.name, imageUrl: widget.imageUrl, price: widget.price, quantity: quantity)
                    );
                    Navigator.of(context).pop(); // Close the modal
                  },
                  
                  child: Text(
                    'Add to Cart',
                    style: GoogleFonts.urbanist(fontSize: 16,color:Colors.black),
                  ),
                ),
                // Close Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: GoogleFonts.urbanist(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
