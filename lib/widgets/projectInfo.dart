import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/screens/payment_screen.dart';

class ProjectInfo extends StatelessWidget {
  String projName, price, deveName, deveImg, imagPath, desc, date, toolUsed;

  ProjectInfo(this.projName, this.price, this.deveName, this.imagPath,
      this.deveImg, this.desc, this.date, this.toolUsed);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9999,
      maxChildSize: 1.0,
      minChildSize: 0.1,
      builder: (cotext, scrollController) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0),
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Description :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        desc,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Project created in $date",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Owners :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(deveImg),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        deveName,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Spacer(),
                      RaisedButton(
                        disabledColor: Colors.white,
                        onPressed: () {},
                        child: Text(
                          "Follow",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.grey)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Tools used :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          toolUsed,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Price :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        price,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    disabledColor: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pushNamed(PaymentScreen.namedRoute);
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Buy Now !",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
