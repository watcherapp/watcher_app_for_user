import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Data/Providers/PropertyManagerProvider.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Components/PropertyManagerComponent.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/CategoryScreen.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/PropertyManagers.dart';
import 'package:watcher_app_for_user/Modules/MasterAdmin/Screens/PropertyManagersDetail.dart';

class MasterAdminDashboard extends StatefulWidget {
  @override
  _MasterAdminDashboardState createState() => _MasterAdminDashboardState();
}

class _MasterAdminDashboardState extends State<MasterAdminDashboard> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PropertyManagerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin", style: TextStyle(fontFamily: 'Montserrat')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 6, right: 6),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: PropertyManagers(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/manager.png",
                                width: 34,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Property Manager's",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: CategoryScreen(),
                                type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/Category.png",
                                width: 32,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/digital-marketing.png",
                              width: 33,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Advertisement",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Montserrat'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/Payment_setting.png",
                              width: 32,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Payment Setting",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Montserrat'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10, right: 6),
              child: Text(
                "Recent Requests",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
            provider.ManagerDatailList.length > 0
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.ManagerDatailList.length,
                    itemBuilder: (context, index) {
                      return PropertyManagetComponent(
                          propertyManagerData:
                              provider.ManagerDatailList[index]);
                    })
                : Center(
                    child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                  )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: PropertyManagers(),
                        type: PageTransitionType.rightToLeft));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "See All",
                    style: TextStyle(
                        // fontFamily: 'Montserrat',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
