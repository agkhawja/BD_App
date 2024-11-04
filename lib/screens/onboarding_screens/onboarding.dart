import 'package:bd_app/auth/signup.dart';
import 'package:bd_app/widgets/onboarding_screens.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int index = 0;
  List<int> page = [
    0,
    1,
    2
  ];

  List<String> maintext = [
    "Explore\nListings",
    "Find\nBusinesses",
    "Browse\nCategories"
  ];
  List<String> image = [
    "images/base.png",
    "images/Mask group.png",
    "images/Mask group1.png",
  ];
  List<String> description = [
    "Our directory app allows you to easily discover local businesses and connect with trusted services, providing a seamless experience all in one convenient place.",
    "Easily find local businesses and services that cater to your needs. Browse through a wide variety of options available right in your area.",
    "Connect directly with verified professionals and explore genuine user reviews. Enjoy a smooth experience in finding the services you need, all within a single app.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingScreens(
        page: page[index],
        mainText: maintext[index],
        image: image[index],
        description: description[index],
        buttonText: index == 2 ? "Get Started" : 'Next',
        onPressed: () {
          setState(() {
            if (index == 0 || index == 1) {
              index++;
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Signup();
                  },
                ),
              );
            }
          });
        },
      ),
    );
  }
}
