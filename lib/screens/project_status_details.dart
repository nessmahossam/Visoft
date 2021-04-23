import 'package:flutter/material.dart';
import 'package:viisoft/widgets/custom_card.dart';

class ProjectStatusDetails extends StatelessWidget {
  static String namedRoute = '/projectStatusDetails';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcfcfe),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Color(0xfffcfcfe),
          title: Text(
            'Cinema App',
            style: TextStyle(color: Color(0xff2f9f9f)),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(
              mileStoneName: 'Milestone 1',
              deadline: '21/2/2021',
              price: '500',
              description:
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia.',
            ),
            CustomCard(
              mileStoneName: 'Milestone 2',
              deadline: '15/3/2021',
              price: '700',
              description:
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia.',
            ),
          ],
        ),
      ),
    );
  }
}
