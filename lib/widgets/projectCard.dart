import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/screens/projectDetails.dart';

class projectCard extends StatelessWidget {
  final String userId,
      img,
      title,
      price,
      deveName,
      deveImg,
      desc,
      date,
      like,
      dislike,
      category,
      toolused;
  final List<dynamic> listOfImages;
  projectCard(
      {this.userId,
      @required this.img,
      @required this.title,
      @required this.price,
      this.category,
      @required this.deveName,
      @required this.deveImg,
      this.desc,
      this.date,
      this.like,
      this.dislike,
      this.listOfImages,
      this.toolused});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({
          "recommended": FieldValue.arrayUnion([category])
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return projectDetails(userId, title, price, deveName, deveImg,
                  listOfImages, like, dislike, date, desc, toolused);
            },
          ),
        );
      },
      child: Container(
        child: Card(
          elevation: 4.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(img), fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Row(
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              "$price EGP",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
