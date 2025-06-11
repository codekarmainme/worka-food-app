import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/screens/checkout_sreen.dart';
import 'package:food_app/widgets/cart_widget.dart';
import 'package:food_app/widgets/place_picker_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? deliveryAddress='Megenagna,Bole,AA';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child:
                Text("Cart", style: GoogleFonts.urbanist(color: Colors.white)),
          ),
          backgroundColor: primaryColor,
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: cartProvider.food_oncart.isNotEmpty?ListView.builder(
                      itemCount: cartProvider.food_oncart.length,
                      itemBuilder: (BuildContext context, int index) {
                        var foodOnCart = cartProvider.food_oncart[index];
                        return CartWidget(
                          amount: foodOnCart.quantity.toString(),
                          imageUrl: foodOnCart.imageUrl,
                          price: foodOnCart.price.toString(),
                          name: foodOnCart.name,
                        );
                      },
                    ):
                    Center(
                      child: Column(
                        children: [
                          Icon(FontAwesomeIcons.cartShopping,color:secondaryColor,size: 100,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Your cart is empty. Please add some foods and drinks!',style:GoogleFonts.urbanist(color:secondaryColor,fontSize:18)),
                          ),
                        ],
                      ),
                    )
                  ),
                  Text(
                    "=Total ETB ${cartProvider.totalbill()}",
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Delivey Address",
                          style: GoogleFonts.urbanist(fontSize: 20),
                        ),
                      )),
                    
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 179, 224, 222),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          deliveryAddress!,
                          style: GoogleFonts.urbanist(color: secondaryColor),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () async  {
                           String? selectedAddress=await showDialog(
                              context: context, builder:(context)=>PlacePickerDialog());
                              print(selectedAddress);
                             if(selectedAddress!=null){
                              setState(() {
                                deliveryAddress=selectedAddress;
                              });
                             }
                          },
                          child: Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                        )
                      ],
                    )),
                  ),
                  SizedBox(height:MediaQuery.of(context).size.height*0.05 ,),
                   Padding(
                     padding: const EdgeInsets.only(left:8.0,right:8),
                     child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); 
                                },
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(width: 1, color:primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: cartProvider.food_oncart.isNotEmpty?() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutSreen(deliveryAddress: deliveryAddress!,),
                                    ),
                                  );
                                }:null,
                                child: Text(
                                  "Check out",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                   ),
                ],
              ),
            );
          },
        ));
  }
}
