import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({required this.hintText, required this.icon,required this.controller,required this.validator});
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: controller,
          autofocus: false,
          style: GoogleFonts.urbanist(),
          validator:validator ,
          
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            hintStyle: GoogleFonts.urbanist(),
            focusColor: Colors.black,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: FaIcon(
                icon
              ),
            ),
          ),
        ),
      ),
    );
  }
}
