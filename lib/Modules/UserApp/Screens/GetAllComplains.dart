import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Modules/UserApp/Screens/UpdateComplain.dart';

class GetAllComplains extends StatefulWidget {
  @override
  _GetAllComplainsState createState() => _GetAllComplainsState();
}

class _GetAllComplainsState extends State<GetAllComplains> {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       automaticallyImplyLeading: false,
  //       leading: IconButton(
  //           icon: Icon(Icons.arrow_back_ios_rounded),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           }),
  //       title: Text("My Complains"),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(5.0),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         height: 150,
  //         child: Card(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   flex: 33,
  //                   child: Container(
  //                     height: 100,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(8),
  //                       image: DecorationImage(
  //                         image:
  //                             NetworkImage("https://picsum.photos/250?image=9"),
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                     // child: Image.network(
  //                     //   'https://picsum.photos/250?image=9',
  //                     // ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 8,
  //                 ),
  //                 Expanded(
  //                   flex: 66,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Expanded(
  //                         flex: 18,
  //                         child: Center(
  //                             child: Text(
  //                           'Complains Category',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.w600,
  //                               fontSize: 15,
  //                               color: Colors.grey[800]),
  //                         )),
  //                       ),
  //                       Align(
  //                         alignment: Alignment.centerRight,
  //                         child: Row(
  //                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             SizedBox(
  //                               width: 10,
  //                             ),
  //                             Text(
  //                               "12 jan 2021",
  //                               style: TextStyle(
  //                                   fontSize: 10,
  //                                   fontWeight: FontWeight.w100,
  //                                   color: Colors.grey[600]),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 8,
  //                       ),
  //                       Container(
  //                         width: 300,
  //                         height: 1,
  //                         color: Colors.grey[400],
  //                       ),
  //                       SizedBox(
  //                         height: 8,
  //                       ),
  //                       // Divider(
  //                       //   thickness: 0.5,
  //                       //   color: Colors.grey[300],
  //                       // ),
  //                       SizedBox(
  //                         height: 8,
  //                       ),
  //                       Expanded(
  //                         flex: 25,
  //                         child: Text(
  //                           'Complains Description: water tap is not working in my sink hiiiiii',
  //                           style: TextStyle(
  //                             color: appPrimaryMaterialColor,
  //                             fontSize: 13,
  //                           ),
  //                           textAlign: TextAlign.start,
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 2,
  //                         ),
  //                       ),
  //                       Expanded(
  //                           flex: 15,
  //                           child: Align(
  //                             alignment: Alignment.center,
  //                             child: GestureDetector(
  //                               onTap: () {
  //                                 Navigator.push(
  //                                     context,
  //                                     PageTransition(
  //                                         child: UpdateComplain(),
  //                                         type:
  //                                             PageTransitionType.rightToLeft));
  //                               },
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 mainAxisSize: MainAxisSize.max,
  //                                 children: [
  //                                   Icon(
  //                                     Icons.edit,
  //                                     size: 20,
  //                                     color: appPrimaryMaterialColor,
  //                                   ),
  //                                   SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Text("Update",
  //                                       style: TextStyle(
  //                                           color: appPrimaryMaterialColor,
  //                                           fontSize: 15,
  //                                           fontWeight: FontWeight.bold)),
  //                                 ],
  //                               ),
  //                             ),
  //                           ))
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("My Complains"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: 150,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://picsum.photos/250?image=9"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: Image.network(
                        //   'https://picsum.photos/250?image=9',
                        // ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Center(
                        child: Text(
                          'Complains Category',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey[800]),
                        ),
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "12 jan 2021",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w100,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 400,
                    height: 1,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Complains Description: water tap is not working in my sink hiiiiii',
                    style: TextStyle(
                      color: appPrimaryMaterialColor,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: UpdateComplain(),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: appPrimaryMaterialColor,
                        ),
                        
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Update",
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
