import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viisoft/screens/project_status_details.dart';

class ProjectStatus extends StatefulWidget {
  static String namedRoute = '/statusScreen';
  @override
  _ProjectStatusState createState() => _ProjectStatusState();
}

class _ProjectStatusState extends State<ProjectStatus> {
  @override
  Widget build(BuildContext context) {
    final bool imageRight = false;
    final Size size = MediaQuery.of(context).size;
    List<Widget> lists = [
      ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        children: [
          Card(
            elevation: 0.5,
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ProjectStatusDetails.namedRoute);
              },
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: imageRight
                          ? BorderRadius.only(
                              topRight: Radius.circular(4.0),
                              bottomRight: Radius.circular(4.0),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              bottomLeft: Radius.circular(4.0),
                            ),
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/reg.jpg',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: 248.0,
                    height: 129.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Cinema App',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Flutter Project',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Developer Name : Bassem & Sandra',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        children: [
          Card(
            elevation: 0.5,
            child: InkWell(
              borderRadius: BorderRadius.circular(4.0),
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: imageRight
                          ? BorderRadius.only(
                              topRight: Radius.circular(4.0),
                              bottomRight: Radius.circular(4.0),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              bottomLeft: Radius.circular(4.0),
                            ),
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/reg.jpg',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: 248.0,
                    height: 129.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Cinema App',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Flutter Project',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Developer Name : Bassem & Sandra',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          // backgroundColor: Theme.of(context).backgroundColor,
          // toolbarHeight: 70,
          //
          title: Text('Project Status'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'In Progress',
              ),
              Tab(
                text: 'Done',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: lists,
        ),
      ),
    );
  }
}
// Card(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Text(
//                     'Cinema App',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontSize: 23.0,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Flutter Project',
//                     style: TextStyle(
//                       fontSize: 15.0,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Developer Name : Bassem & Sandra',
//                         style: TextStyle(
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: size.width / 3,
//                         height: size.height / 25,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.grey,
//                                 blurRadius: 15.0,
//                                 offset: Offset(0.0, 5.0)),
//                           ],
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         child: FlatButton(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Text(
//                                 'View Details',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w900,
//                                   fontSize: 13.0,
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 15.0,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

// Align(
//   alignment: Alignment.bottomRight,
//   child: Padding(
//     padding: const EdgeInsets.symmetric(
//         horizontal: 4, vertical: 0),
//     child: Container(
//       width: size.width / 3,
//       height: size.height / 25,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey,
//               blurRadius: 15.0,
//               offset: Offset(0.0, 5.0)),
//         ],
//         borderRadius: BorderRadius.circular(30.0),
//       ),
//       child: FlatButton(
//         child: Row(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'View Details',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w900,
//                 fontSize: 13.0,
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15.0,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         onPressed: () {},
//       ),
//     ),
//   ),
// ),
