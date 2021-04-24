import 'package:flutter/material.dart';
import 'package:viisoft/screens/home_screen.dart';

class CategorySection extends StatefulWidget {
  IconData icon;
  String label;
  CategorySection(this.icon, this.label);

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          Home.category = widget.label;
          print(Home.category);
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.blueGrey,
                  size: 20,
                ),
                SizedBox(height: 14),
                Text(
                  widget.label,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
