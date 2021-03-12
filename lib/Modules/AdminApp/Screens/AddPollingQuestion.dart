import 'package:flutter/material.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';

class AddPollingQuestion extends StatefulWidget {
  @override
  _AddPollingQuestionState createState() => _AddPollingQuestionState();
}

class _AddPollingQuestionState extends State<AddPollingQuestion> {
  // TextEditingController txt1 = new TextEditingController();
  // TextEditingController txt2 = new TextEditingController();
  // TextEditingController txt3 = new TextEditingController();
  // TextEditingController txt4 = new TextEditingController();
  //
  // List controller;
  //
  // @override
  // void initState() {
  //   controller = [
  //     "${txt1}",
  //     "${txt2}",
  //     "${txt3}",
  //     "${txt4}",
  //   ];
  //
  // }
  //
  // int indeX = 0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> friendsList = [null];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       automaticallyImplyLeading: false,
  //       leading: IconButton(
  //           icon: Icon(Icons.arrow_back_ios_rounded),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           }),
  //       title: Text(
  //         "Add Polling Questions",
  //         style: TextStyle(fontFamily: 'Montserrat'),
  //       ),
  //       centerTitle: true,
  //       elevation: 0,
  //       backgroundColor: appPrimaryMaterialColor,
  //     ),
  //     body: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           Expanded(
  //             child: ListView(
  //               //crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: <Widget>[
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     labelText: 'Question',
  //                   ),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 Center(
  //                   child: Text('Options'),
  //                 ),
  //                 SizedBox(height: 16.0),
  //                 for (int i = 0; i < indeX; i++) ...[
  //                   MyTextFormField(
  //                       controller: txt1,
  //                       lable: "First Name",
  //                       validator: (val) {
  //                         if (val.isEmpty) {
  //                           return "Please Enter First Name";
  //                         }
  //                         return "";
  //                       },
  //                       hintText: "Enter first name"),
  //                 ],
  //                 RaisedButton.icon(
  //                   icon: Icon(Icons.add),
  //                   label: Text('Add Options'),
  //                   onPressed: () {
  //                     setState(() {
  //                       indeX++;
  //                     });
  //                   },
  //                 ),
  //                 RaisedButton.icon(
  //                   icon: Icon(Icons.minimize),
  //                   label: Text('Remove Options'),
  //                   onPressed: () {
  //                     setState(() {
  //                       indeX--;
  //                     });
  //                   },
  //                 ),
  //                 SizedBox(height: 16.0),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Add Polling Questions",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appPrimaryMaterialColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name textfield
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration:
                        InputDecoration(hintText: 'Enter your Question'),
                    validator: (v) {
                      if (v.trim().isEmpty) return 'Please enter something';
                      return null;
                    },
                  ),
                ),
                // MyTextFormField(
                //   controller: _nameController,
                //   lable: "First Name",
                //   validator: (val) {
                //     if (val.trim().isEmpty) {
                //       return "Please Enter Question";
                //     }
                //     return "";
                //   },
                //   hintText: "Enter your Question",
                // ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Options :',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: appPrimaryMaterialColor),
                ),
                ..._getFriends(),
                SizedBox(
                  height: 40,
                ),
                // FlatButton(
                //   onPressed: () {
                //     if (_formKey.currentState.validate()) {
                //       _formKey.currentState.save();
                //     }
                //   },
                //   child: Text('Submit'),
                //   color: Colors.green,
                // ),
                MyButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                  title: "Submit",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Text("${i + 1})"),
            SizedBox(
              width: 6,
            ),
            Expanded(child: QuestionTextFields(i)),
            SizedBox(
              width: 6,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
        } else
          friendsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class QuestionTextFields extends StatefulWidget {
  final int index;

  QuestionTextFields(this.index);

  @override
  _QuestionTextFieldsState createState() => _QuestionTextFieldsState();
}

class _QuestionTextFieldsState extends State<QuestionTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _AddPollingQuestionState.friendsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _AddPollingQuestionState.friendsList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter your Option'),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter Option${widget.index}';
        return null;
      },
    );
  }
}
