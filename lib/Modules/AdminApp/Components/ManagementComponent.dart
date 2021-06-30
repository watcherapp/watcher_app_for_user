import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class ManagementComponent extends StatefulWidget {
  var memberData;
  Function memberDataApi;

  ManagementComponent({
    this.memberData,
    this.memberDataApi,
  });

  @override
  _ManagementComponentState createState() => _ManagementComponentState();
}

class _ManagementComponentState extends State<ManagementComponent> {
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                widget.memberData["memberImage"] == null ||
                        widget.memberData["memberImage"] == ""
                    ? Image.asset(
                        'images/user.png',
                        width: 70,
                        height: 70,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Container(
                          height: 70.0,
                          width: 70,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 0.2, color: appPrimaryMaterialColor),
                            image: DecorationImage(
                              image: NetworkImage(
                                API_URL + widget.memberData["memberImage"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: Text(
                        "${widget.memberData["firstName"]} ${widget.memberData["lastName"]}",
                        style: TextStyle(
                          color: appPrimaryMaterialColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.memberData["FlatData"][0]["WingData"][0]["wingName"]}-${widget.memberData["FlatData"][0]["flatNo"]}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'WorkSans Bold',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${widget.memberData["mobileNo1"]}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'WorkSans Bold',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.memberData["FlatData"][0]["flatStatus"] == "0"
                          ? "Dead"
                          : widget.memberData["FlatData"][0]["flatStatus"] ==
                                  "1"
                              ? "Closed"
                              : widget.memberData["FlatData"][0]
                                          ["flatStatus"] ==
                                      "2"
                                  ? "Rent"
                                  : "Owner",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'WorkSans Bold',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                IconButton(
                  onPressed: () {
                    launchUrl("tel:${{widget.memberData["mobileNo1"]}}");
                    print(widget.memberData["mobileNo1"]);
                  },
                  icon: Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  iconSize: 25,
                ),
                IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: MemberAllInfo(
                    //           memberMobileNo: widget.memberData["mobileNo1"],
                    //           memberId: widget.memberData["_id"],
                    //           memberApi: () {
                    //             widget.memberDataApi();
                    //           },
                    //         ),
                    //         type: PageTransitionType.rightToLeft));
                  },
                  icon: Icon(Icons.message),
                  iconSize: 25,
                )
                // SizedBox(
                //   width: 105,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
