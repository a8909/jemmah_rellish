import 'package:flutter/material.dart';
import 'package:jemmah_rellish/onboardingScreens/screen3.dart';
import 'package:jemmah_rellish/onboardingScreens/screen_1.dart';
import 'package:jemmah_rellish/onboardingScreens/screen_2.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreenFirstPageState();
}

class _OnboardingScreenFirstPageState extends State<OnboardingScreens> {
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              onLastPage = (index == 2);
            },
            children: const [Onboard1(), Onboarding2(), Onbooarding3()],
          ),
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                children: [
                  GestureDetector(
                      // onTap: () => ,
                      child: const Text('skip')),
                  // smoothPageIndicator(controller: _controller, count: 3),
                  onLastPage
                      ? GestureDetector(child: const Text('Done'))
                      : GestureDetector(child: const Text('Next'))
                ],
              ))
        ],
      ),
    );
  }
}
