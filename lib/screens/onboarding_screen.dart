import 'package:flutter/material.dart';

import 'package:viisoft/data.dart';
import 'package:viisoft/screens/register_screen.dart';
import 'package:viisoft/screens/welcome_screen.dart';
import 'package:viisoft/widgets/custom_wigedt.dart';

class OnboardingScreen extends StatelessWidget {
  static String namedRoute = '/onboardingScreen';
  @override
  Widget build(BuildContext context) {
    int totalPages = OnboardingItems.loadOnboardingItem().length;
    return Scaffold(
      body: PageView.builder(
        itemCount: totalPages,
        itemBuilder: (BuildContext context, int index) {
          OnboardingItem oi = OnboardingItems.loadOnboardingItem()[index];
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: oi.color,
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Text(
                        'SKIP',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
                PImage(
                  img: oi.image,
                  imgHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                Column(
                  children: [
                    Text(
                      oi.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      oi.subtitle,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    index == (totalPages - 1)
                        ? CustomButton(
                            btnText: 'Get Started',
                            btnFn: () {
                              Navigator.of(context).pushReplacementNamed(
                                  WelcomeScreen.namedRoute);
                            },
                          )
                        : Container(),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: totalPages,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: index == i ? 60 : 20,
                          color: index == i ? Colors.white70 : Colors.white30,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
