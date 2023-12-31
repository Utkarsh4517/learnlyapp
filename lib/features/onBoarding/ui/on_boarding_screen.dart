import 'package:learnlyapp/shared/custom_button.dart';
import 'package:learnlyapp/shared/nav_bar.dart';
import 'package:learnlyapp/features/onBoarding/ui/intro_page2.dart';
import 'package:learnlyapp/features/onBoarding/ui/intro_page3.dart';
import 'package:learnlyapp/features/onBoarding/ui/intro_page1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenOnboarding', true);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const NavigationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onLastPage)
                  Container(
                    margin: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                          text: 'Done',
                          function: () {
                            _completeOnboarding();
                          })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
