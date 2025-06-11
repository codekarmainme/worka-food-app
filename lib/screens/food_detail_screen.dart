import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/model/food_oncart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen(
      {super.key,
      required this.imageUrl,
      required this.ingredients,
      required this.foodName,
      required this.price
      });
  final String imageUrl;
  final String foodName;
  final List<String> ingredients;
  final num price;
  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int counter=0; 
  void increaseCounter(){
    setState(() {
      
      counter=counter+1;
    });
  }
  void decreaseCounter(){
    if(counter>0){
      setState(() {
      
      counter=counter-1;
    });
    }
    
  }
  void addTocart(){
   Provider.of<CartProvider>(context, listen: false).addTocart(
                   FoodOnCartItem(name: widget.foodName, imageUrl: widget.imageUrl, price: widget.price, quantity: counter)
                    );
                    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white)),
              Text(widget.foodName,style: GoogleFonts.urbanist(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.white),),
            Icon(
              Icons.bookmark_border,
              color: Colors.white,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                    widget.imageUrl,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                           "ETB ${widget.price.toString()}" ,
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: secondaryColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Werka Coffee House",
                        style: GoogleFonts.urbanist(),
                      )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Ingredients",
                      style: GoogleFonts.urbanist(fontSize: 18),
                    )),
              ),
              Container(
                height: 20,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.ingredients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          widget.ingredients[index],
                          style: GoogleFonts.urbanist(color: Colors.black),
                        ),
                      );
                    }),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
             Container(
              width:MediaQuery.of(context).size.width*0.4,
              height:40,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(20),
                color:counterbtnColor,
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: decreaseCounter,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: secondaryColor
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(FontAwesomeIcons.minus,color: Colors.white,)
                      ),
                    ),
                  ),
                  Text(counter.toString(),style: GoogleFonts.urbanist(color: Colors.white,fontSize: 20),),
                  GestureDetector(
                    onTap: increaseCounter,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: secondaryColor
                      ),
                      child: Icon(Icons.add,color: Colors.white,)),
                  )
                ],
              ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*0.05,),
             GestureDetector(
              onTap: addTocart,
               child: Container(
                width: MediaQuery.of(context).size.width*0.5,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child: Text("Add to cart",style: GoogleFonts.urbanist(color:Colors.white,fontSize: 20),)),
               ),
             )
        
            ],
          ),
        ),
      ),
    );
  }
}
