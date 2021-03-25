import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyCustomDropDown.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/appColors.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/SetupWings.dart';

class CreateNewSociety extends StatefulWidget {
  @override
  _CreateNewSocietyState createState() => _CreateNewSocietyState();
}

class _CreateNewSocietyState extends State<CreateNewSociety> {
  String selectedSocietyType, selectedCountry, selctedState, selectedCity;
  bool isLoading = false;
  List countryList = [];
  List stateList = [];
  List cityList = [];
  List societyTypeList = [];

  TextEditingController txtSocName = new TextEditingController();
  TextEditingController txtWingNumber = new TextEditingController();
  TextEditingController txtZipCode = new TextEditingController();

  _getAllSocietyCategory() async {
    try {
      setState(() {
        isLoading = true;
      });
      //LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        Services.responseHandler(
          apiName: "api/society/getAllSocietyCategory",
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            print("getAllSocietyCategory -- >${responseData.Data}");
            societyTypeList = responseData.Data;
            print("------------------------>${societyTypeList}");
            // List myCategoryList = responseData.Data;
            // for (int i = 0; i < responseData.Data.length; i++) {
            //   societyTypeList.add(myCategoryList[i]["categoryName"]);
            // }
            setState(() {
              isLoading = false;
            });
          } else {
           print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                backgroundColor: Colors.white,
                textColor: appPrimaryMaterialColor,
                );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
              );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          backgroundColor: Colors.white,
          textColor: appPrimaryMaterialColor,
          );
    }
  }

  _createSociety() async {
    try {
      setState(() {
        isLoading = true;
      });
      //LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "secretaryId": "6038834fd00ee22d24a09c77",
          "societyName": "Raghuvir",
          "totalWings": "3",
          "country": "india",
          "state": "gujarat",
          "city": "surat",
          "lat": "21.0541351",
          "long": "72.151513",
          "completeAddress": "Vip road ,Vesu , surat",
          "categoryId": "600574f31afece007c40804e"
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/createSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            setState(() {
              isLoading = false;
            });
          } else {
           print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                backgroundColor: Colors.white,
                textColor: appPrimaryMaterialColor,
                );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
              );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          backgroundColor: Colors.white,
          textColor: appPrimaryMaterialColor,
          );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.red,
      //     content: Text("You aren't connected to the Internet !"),
      //   ),
      // );
    }
  }

  _getAllCountries() async {
    try {
      setState(() {
        isLoading = true;
      });
      //LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        Services.responseHandler(
          apiName: "api/admin/getAllCountry",
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            print("getAllCountries -- >${responseData.Data}");
            countryList = responseData.Data;
            print("------------------------>${countryList}");
            // List mycountryList = responseData.Data;
            // for (int i = 0; i < responseData.Data.length; i++) {
            //   countryList.add(mycountryList[i]["name"]);
            // }
            setState(() {
              isLoading = false;
            });
          } else {
           print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                backgroundColor: Colors.white,
                textColor: appPrimaryMaterialColor,
                );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
              );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          backgroundColor: Colors.white,
          textColor: appPrimaryMaterialColor,
          );
    }
  }

  _getAllstate(var selectedCountry) async {
    try {
      setState(() {
        isLoading = true;
      });
      //LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "countryCode": selectedCountry,
        };
        print("$body");
        Services.responseHandler(
          apiName: "api/admin/getState",
          body: body,
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            print("getAllstate -- >${responseData.Data}");
            stateList = responseData.Data;
            print("------------------------>${stateList}");
            // List mystateList = responseData.Data;
            // for (int i = 0; i < responseData.Data.length; i++) {
            //   countryList.add(mystateList[i]["name"]);
            // }
            setState(() {
              isLoading = false;
            });
          } else {
           print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                backgroundColor: Colors.white,
                textColor: appPrimaryMaterialColor,
                );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
              );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          backgroundColor: Colors.white,
          textColor: appPrimaryMaterialColor,
          );
    }
  }

  _getAllCity() async {
    try {
      setState(() {
        isLoading = true;
      });
      //LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "countryCode": "IN",
          "stateCode": "GJ",
        };
        Services.responseHandler(
          apiName: "api/admin/getCity",
          body: body,
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            print("getAllCity -- >${responseData.Data}");
            cityList = responseData.Data;
            setState(() {
              isLoading = false;
            });
          } else {
           print(responseData);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                backgroundColor: Colors.white,
                textColor: appPrimaryMaterialColor,
                );
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              backgroundColor: Colors.white,
              textColor: appPrimaryMaterialColor,
              );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          backgroundColor: Colors.white,
          textColor: appPrimaryMaterialColor,
          );
    }
  }

  @override
  void initState() {
    _getAllSocietyCategory();
    _getAllCountries();
    // _getAllstate();
    // _getAllCity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Society"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingConstant.createSocietyScreenPadding,
          child: Column(
            children: [
              MyCustomDropDown(
                lable: "Society Type",
                hintText: "Society Type",
                value: selectedSocietyType,
                displayName: "categoryName",
                hiddenValue: "_id",
                myListValue: societyTypeList,
              ),
              MyTextFormField(
                  controller: txtSocName,
                  lable: "Society Name",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Society Name";
                    }
                    return "";
                  },
                  hintText: "Enter Society Name"),
              MyTextFormField(
                  controller: txtWingNumber,
                  lable: "Total Wings or Apartment buildings",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Total Wings or Apartment buildings";
                    }
                    return "";
                  },
                  hintText: "Enter Total Wings or Apartment buildings"),
              MyCustomDropDown(
                lable: "Select Country",
                hintText: "Select Country",
                value: selectedCountry,
                displayName: "name",
                hiddenValue: "isoCode",
                myListValue: countryList,
                functionName: () {
                  _getAllstate(selectedCountry);
                },
              ),
              MyCustomDropDown(
                lable: "Select State",
                hintText: "Select State",
                value: selctedState,
                displayName: "name",
                hiddenValue: "isoCode",
                myListValue: stateList,
              ),
              // MyCustomDropDown(
              //   lable: "Select City",
              //   hintText: "Select City",
              //   value: selectedCity,
              //   displayName: "categoryName",
              //   // hiddenValue: "_id",
              //   myListValue: cityList,
              // ),
              MyTextFormField(
                  controller: txtZipCode,
                  lable: "Zip or Code",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Zip or code";
                    }
                    return "";
                  },
                  hintText: "Enter zip or code"),
              MyButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SetupWings(),
                            type: PageTransitionType.rightToLeft));
                  },
                  title: "Submit"),
              // DialogOpenFormField(
              //     lable: "Select State",
              //     value: selctedState,
              //     onTap: () {
              //       // print("click");
              //       FocusScope.of(context).unfocus();
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return MyDropDown(
              //                 myHeight: 300,
              //                 dropDownTitle: "Select State",
              //                 dropDownData: stateList,
              //                 onSelectValue: (value) {
              //                   setState(() {
              //                     selctedState = value;
              //                   });
              //                 });
              //           });
              //     }),
              // DialogOpenFormField(
              //     lable: "Select City",
              //     value: selectedCity,
              //     onTap: () {
              //       // print("click");
              //       FocusScope.of(context).unfocus();
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return MyDropDown(
              //                 myHeight: 300,
              //                 dropDownTitle: "Select City",
              //                 dropDownData: cityList,
              //                 onSelectValue: (value) {
              //                   setState(() {
              //                     selectedCity = value;
              //                   });
              //                 });
              //           });
              //     }),
              // DialogOpenFormField(
              //     lable: "Society Type",
              //     value: selectedSocietyType,
              //     onTap: () {
              //       // print("click");
              //       FocusScope.of(context).unfocus();
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return MyDropDown(
              //                 dropDownTitle: "Society Type",
              //                 dropDownData: societyTypeList,
              //                 onSelectValue: (value) {
              //                   setState(() {
              //                     selectedSocietyType = value;
              //                   });
              //                 });
              //           });
              //     }),
              // Padding(
              //   padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.grey[200],
              //         borderRadius: BorderRadius.circular(8.0)),
              //     child: DropdownButtonHideUnderline(
              //       child: ButtonTheme(
              //         alignedDropdown: true,
              //         child: DropdownButton<String>(
              //           isExpanded: true,
              //           value: selectedCountry,
              //           iconSize: 30,
              //           icon: (null),
              //           style: TextStyle(
              //             color: Colors.black54,
              //             fontSize: 16,
              //           ),
              //           hint: Text('Select Locality'),
              //           onChanged: (String newValue) {
              //             setState(() {
              //               var locality = '';
              //               selectedCountry = newValue;
              //               locality = newValue.toString();
              //               print(selectedCountry);
              //             });
              //           },
              //           items: countryList?.map((item) {
              //                 return new DropdownMenuItem(
              //                   child: new Text(item['name']),
              //                   value: item['isoCode'].toString(),
              //                 );
              //               })?.toList() ??
              //               [],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // DialogOpenFormField(
              //     lable: "Select Country",
              //     value: selectedCountry,
              //     onTap: () {
              //       // print("click");
              //       FocusScope.of(context).unfocus();
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return MyDropDown(
              //                 myHeight: 300,
              //                 dropDownTitle: "Select Country",
              //                 dropDownData: countryList,
              //                 onSelectValue: (value) {
              //                   setState(() {
              //                     selectedCountry = value;
              //                   });
              //                 });
              //           });
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
