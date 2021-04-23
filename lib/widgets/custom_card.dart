import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String mileStoneName;
  final String price;
  final String description;
  final String deadline;

  CustomCard({this.mileStoneName, this.price, this.description, this.deadline});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Color(0xff2f9f9f)),
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xff84b4c1).withOpacity(.4),
          blurRadius: 10,
          offset: Offset(1, 6),
        )
      ]),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                mileStoneName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Deadline: ' + deadline,
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2f9f9f)),
                  ),
                  Text(
                    price + ' EGP',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Description: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2f9f9f),
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
