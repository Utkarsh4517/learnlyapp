import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnlyapp/constants/colors.dart';
import 'package:learnlyapp/constants/dimensions.dart';

class CustomPinkText extends StatelessWidget {
  final String text;
  final double sizeFactor;
  const CustomPinkText({
    required this.text,
    required this.sizeFactor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getScreenWidth(context) * 0.05,
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: pinkColor,
          fontWeight: FontWeight.w900,
          fontSize: getScreenWidth(context) * sizeFactor,
        ),
      ),
    );
  }
}
