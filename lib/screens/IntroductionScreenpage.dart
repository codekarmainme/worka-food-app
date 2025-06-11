import 'package:flutter/material.dart';
import 'package:food_app/widgets/intoduction_screen_widget.dart';
class IntroductionScreenpage extends StatelessWidget {
  const IntroductionScreenpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height:MediaQuery.of(context).size.height,
        child: IntoductionScreenWidget(),
      )
    );
  }
}