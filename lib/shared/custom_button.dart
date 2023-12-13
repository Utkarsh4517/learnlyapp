import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnlyapp/constants/colors.dart';
import 'package:learnlyapp/constants/dimensions.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback function;
  const CustomButton({
    required this.text,
    required this.function,
    super.key,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
        widget.function();
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(
          horizontal: getScreenWidth(context) * (isTapped ? 0.12 : 0.15),
          vertical: getScreenWidth(context) * 0.045,
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: getScreenWidth(context) * 0.035,
          ),
        ),
      ),
    );
  }
}
