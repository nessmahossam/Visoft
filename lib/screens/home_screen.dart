import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viisoft/constants.dart';
import 'package:viisoft/models/category_model.dart';
import 'package:viisoft/widgets/category_section.dart';
import 'package:viisoft/widgets/projectCard.dart';

class Home extends StatefulWidget {
  static String namedRoute = '/homePage';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(statusList.length);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  CategorySection(
                      FontAwesomeIcons.mobileAlt, "Mobile Application"),
                  CategorySection(
                      FontAwesomeIcons.desktop, "Desktop Application"),
                  CategorySection(
                      FontAwesomeIcons.laptopCode, "Web Application"),
                  CategorySection(FontAwesomeIcons.images, "UI/UX"),
                  CategorySection(FontAwesomeIcons.clinicMedical, "Medical"),
                  CategorySection(FontAwesomeIcons.shoppingCart, "E-Commerce"),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return projectCard(
                    statusList[index]['img'],
                    statusList[index]['title'],
                    statusList[index]['price'],
                    statusList[index]['userName'],
                    statusList[index]['userImg'],
                  );
                },
                itemCount: statusList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
