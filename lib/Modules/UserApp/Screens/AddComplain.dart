import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/DialogOpenFormField.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Dialogs/MyDropdown.dart';

class AddComplain extends StatefulWidget {
  @override
  _AddComplainState createState() => _AddComplainState();
}

class _AddComplainState extends State<AddComplain> {
  List CategoryList = [
    "garden",
    "misbehaviour",
    "garden",
    "misbehaviour",
  ];
  String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Add Complain"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3),
                child: DialogOpenFormField(
                    lable: "Select Category of Complains",
                    hintLable: "Complains Category",
                    value: categoryName,
                    onTap: () {
                      // print("click");
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: MyDropDown(
                            dropDownTitle: "Complains Category",
                            dropDownData: CategoryList,
                            isSearchable: false,
                            onSelectValue: (value) {
                              setState(() {
                                categoryName = value;
                              });
                            },
                            // onSelectValue: ,
                          ),
                        ),
                      );
                    }),
              ),
              MyTextFormField(
                lable: "Description",
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
                keyboardType: TextInputType.multiline,
                maxLines: null,
                hintText: "Enter Description of Complains",
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                child: Text("Complains Related Photo",
                    style: fontConstants.formFieldLabel),
              ),
              // SizedBox(height: 10,),
              Column(
                children: [
                  containerdash,
                  SizedBox(height: 20),
                  Text("Select Photo Proof", style: fontConstants.smallText),
                ],
              ),
              MyButton(
                onPressed: () {},
                title: "Add Complains",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get containerdash {
    return Center(
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [5, 5, 5, 5],
        color: Colors.grey[400],
        child: Container(
          height: 129,
          width: 360,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0x22888888),
          ),
          child: Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 70,
              ),
              decoration: new BoxDecoration(
                color: Colors.grey[300],
                borderRadius: new BorderRadius.all(new Radius.circular(90.0)),
                border: new Border.all(color: Colors.grey[300], width: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
