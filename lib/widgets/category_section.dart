import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  IconData icon;
  String label;
  CategorySection(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.blueGrey,
                  size: 20,
                ),
                SizedBox(height: 14),
                Text(
                  label,
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
