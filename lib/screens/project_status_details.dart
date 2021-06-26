import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/widgets/custom_card.dart';

class ProjectStatusDetails extends StatefulWidget {
  static String namedRoute = '/projectStatusDetails';
  static String docId;
  static String collectionID;

  @override
  _ProjectStatusDetailsState createState() => _ProjectStatusDetailsState();
}

class _ProjectStatusDetailsState extends State<ProjectStatusDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cinema App',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      // CustomCard(
      //   mileStoneName: 'Milestone 1',
      //   deadline: '21/2/2021',
      //   price: '500',
      //   description:
      //       'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia.',
      // ),
      //       CustomCard(
      //         mileStoneName: 'Milestone 2',
      //         deadline: '15/3/2021',
      //         price: '700',
      //         description:
      //             'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia.',
      //       ),
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection(ProjectStatusDetails.collectionID)
                .doc(ProjectStatusDetails.docId)
                .collection("MileStones")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      mileStoneName: snapshot.data.docs[index].data()['title'],
                      deadline: snapshot.data.docs[index].data()['deadLine'],
                      price: snapshot.data.docs[index].data()['price'],
                      description: snapshot.data.docs[index].data()['desc'],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
