import 'package:flutter/material.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final String image;
  final Color color;

  const OnboardingItem({this.title, this.subtitle, this.image, this.color});
}

class OnboardingItems {
  static List<OnboardingItem> loadOnboardingItem() {
    final screens = <OnboardingItem>[
      OnboardingItem(
          title: "All Your Projects in One Place",
          subtitle: "As a developer, upload your projects fast and easy",
          image: "assets/images/code_development_.png",
          color: Color(0xff2F9F9F)),
      OnboardingItem(
          title: "Looking For a Specific Software?",
          subtitle: "Find as many and different softwares and applications.",
          image: "assets/images/search_engine.png",
          color: Color(0xff2F9F9F)),
      OnboardingItem(
          title: "Quick & Secure Payment and Money Transfer",
          subtitle:
              "Transfer money with ease and security from anywhere you are.",
          image: "assets/images/money_transfer_.png",
          color: Color(0xff2F9F9F)),
      OnboardingItem(
          title: "So, What are You Waiting For?!",
          subtitle: "",
          image: "assets/images/moving_forward.png",
          color: Color(0xff2F9F9F)),
    ];
    return screens;
  }
}
