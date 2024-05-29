import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String headline;
  final String description;
  final PageController controller;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.headline,
    required this.description,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          width: 250,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(
          headline,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
            wordSpacing: 1.0,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
            height: 30), // Add spacing between the text and indicators
        SmoothPageIndicator(
          controller: controller,
          count: 4,
          effect: const WormEffect(
            dotWidth: 8.0,
            dotHeight: 8.0,
            spacing: 8.0,
          ),
          onDotClicked: (index) {
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}
