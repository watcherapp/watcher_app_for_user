import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class BusinessCategory extends StatefulWidget {
  @override
  _BusinessCategoryState createState() => _BusinessCategoryState();
}

class _BusinessCategoryState extends State<BusinessCategory> {
  bool isAdd = false;
  final TextEditingController txtguestname = new TextEditingController();
  List tempList = [];

  @override
  void initState() {
    print("${isAdd}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Business Category",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          isAdd == true
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: MyTextFormField(
                                controller: txtguestname,
                                lable: "Business Name",
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please Enter Business Name";
                                  }
                                  return "";
                                },
                                hintText: "Type Business Name"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7.0, top: 29),
                            child: Container(
                              width: 90,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                height: 32,
                                color: appPrimaryMaterialColor,
                                onPressed: () {
                                  if (txtguestname.text != "") {
                                    setState(() {
                                      tempList.add(txtguestname.text);
                                      txtguestname.text = "";
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Data Added Successfully");
                                  }
                                },
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 13),
                              child: Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 5, bottom: 18),
                        scrollDirection: Axis.vertical,
                        itemCount: tempList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(tempList[index]),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tempList.removeAt(index);
                                      //tempList.remove(txtguestname.text);
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Data Deleted Successfully");
                                  },
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: appPrimaryMaterialColor,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 13),
                              child: Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 5, bottom: 18),
                        scrollDirection: Axis.vertical,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("megha solanki"),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 120,
                        child: FlatButton(
                          height: 32,
                          color: Colors.grey[200],
                          onPressed: () {
                            setState(() {
                              isAdd = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline_sharp,
                                  color: appPrimaryMaterialColor, size: 17),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  "Add More",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: appPrimaryMaterialColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
