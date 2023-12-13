import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnlyapp/constants/colors.dart';
import 'package:learnlyapp/constants/dimensions.dart';
import 'package:learnlyapp/shared/custom_text.dart';
class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/img/mother2.svg', width: getScreenheight(context) * 0.4,),
            const CustomPinkText(text: 'LOREL IPSUM', sizeFactor: 0.06)
          ],
        )
      ),
    );
  }
}
