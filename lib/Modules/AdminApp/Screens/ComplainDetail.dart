import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class ComplainDetail extends StatefulWidget {
  @override
  _ComplainDetailState createState() => _ComplainDetailState();
}

class _ComplainDetailState extends State<ComplainDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Waste Disposal management Event",
              //'${widget.notification["Title"]}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Image.network(
            "https://cityspideynews.s3.amazonaws.com/uploads/spidey/201906/grihapravesh_061319062347.jpg",
            height: 170,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
            child: Text(
              "   They complained that the association, which takes care of the society's maintenance, is not allowing them to access the power backup facility and also charging exorbitant rates for the same.\n\n   Avnish Jha, who has shifted to his flat recently, said that the problem is happening with the people who have bought unsold inventories from the developer. He added that they are allowed to use limited facilities different than other residents.",
              //'${widget.notification["Title"]}',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Montserrat',
                //        fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}
