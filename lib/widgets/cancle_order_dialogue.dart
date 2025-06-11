import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CancelOrderDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final BuildContext context;
  final num orderno;

  const CancelOrderDialog({
    Key? key,
    required this.onConfirm,
    required this.context,
    required this.orderno
    
  }) : super(key: key);
  Future<void> _deteleOrder(BuildContext context,num orderno)async{
    await Provider.of<CartProvider>(context,listen:false).deleteOrder(orderno);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancel Order',style: GoogleFonts.poppins(),),
      content: Text('Are you sure you want to cancel this order?',style: GoogleFonts.poppins()),
      
      actions: [
          ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('Cancle',style: GoogleFonts.poppins(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor
          ),
        ),
        
        TextButton(
          onPressed: (){
            _deteleOrder(context, orderno);
            Navigator.pop(context);
          },
         style: TextButton.styleFrom(
          overlayColor: primaryColor,
          side: BorderSide(width: 1,color:primaryColor),
          minimumSize: Size(70, 40)
         ),
          child: Text('Confirm',style: GoogleFonts.poppins(color:primaryColor)),
        ),
      
      ],
    );
  }
}