import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/SetupWings.dart';

class CreateNewSociety extends StatefulWidget {
  @override
  _CreateNewSocietyState createState() => _CreateNewSocietyState();
}

class _CreateNewSocietyState extends State<CreateNewSociety> {
  String selectedCountry = "";
  String selectedState = "";
  String selectedCity = "";
  String selectedSocietyType = "";
  bool isCountryLoading = false;
  bool isStateLoading = false;
  bool isCityLoading = false;
  bool isLoading = false;
  List stateList = [];
  List countryList = [];
  List societyTypeList = [];
  List cityList = [];
  TextEditingController txtSocName = TextEditingController();
  TextEditingController txtWingNumber = TextEditingController();
  TextEditingController txtStreetName = TextEditingController();
  TextEditingController txtStreetAddress = TextEditingController();
  TextEditingController txtZipCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllSocietyCategory();
    _getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Society Type", style: fontConstants.formFieldLabel),
              SizedBox(height: 3),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey[200],
                ),
                child: SearchableDropdown.single(
                  items: societyTypeList.map((value) {
                    return (DropdownMenuItem(
                      child: Text(value["categoryName"]),
                      value: value["_id"],
                    ));
                  }).toList(),
                  value: selectedSocietyType,
                  hint: "Select Society Type",
                  isCaseSensitiveSearch: false,
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                  searchHint: "Select Society Type",
                  onChanged: (value) {
                    setState(() {
                      selectedSocietyType = value;
                    });
                    print(selectedSocietyType);
                  },
                  dialogBox: true,
                  displayClearIcon: false,
                  isExpanded: true,
                ),
              ),
              MyTextFormField(
                  controller: txtSocName,
                  lable: "Society Name",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Society Name";
                    }
                    return null;
                  },
                  hintText: "Enter Society Name"),
              MyTextFormField(
                  controller: txtWingNumber,
                  lable: "Total Wings or Apartment buildings",
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Total Wings or Apartment buildings";
                    }
                    return null;
                  },
                  hintText: "Enter Total Wings or Apartment buildings"),
              SizedBox(height: 10),
              Text("Country", style: fontConstants.formFieldLabel),
              SizedBox(height: 3),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey[200],
                ),
                child: SearchableDropdown.single(
                  items: countryList.map((value) {
                    return (DropdownMenuItem(
                      child: Text(value["name"]),
                      value: value["isoCode"],
                    ));
                  }).toList(),
                  value: selectedCountry,
                  hint: "Select Country",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                  searchHint: "Select Country",
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                    _getAllstate(selectedCountry);
                  },
                  dialogBox: true,
                  displayClearIcon: false,
                  isCaseSensitiveSearch: false,
                  isExpanded: true,
                ),
              ),
              SizedBox(height: 15),
              Text("State", style: fontConstants.formFieldLabel),
              SizedBox(height: 3),
              isStateLoading == true
                  ? CircularProgressIndicator()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.grey[200],
                      ),
                      child: SearchableDropdown.single(
                        items: stateList.map((value) {
                          return (DropdownMenuItem(
                            child: Text(value["name"]),
                            value: value["isoCode"],
                          ));
                        }).toList(),
                        value: selectedState,
                        hint: "Select State",
                        isCaseSensitiveSearch: false,
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                        searchHint: "Select State",
                        onChanged: (value) {
                          setState(() {
                            selectedState = value;
                          });
                          _getAllCity(
                              selectedCountry: selectedCountry,
                              selectedState: selectedState);
                          // _getAllstate(selectedState);
                        },
                        dialogBox: true,
                        displayClearIcon: false,
                        isExpanded: true,
                      ),
                    ),
              SizedBox(height: 15),
              Text("City", style: fontConstants.formFieldLabel),
              SizedBox(height: 3),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.grey[200],
                ),
                child: SearchableDropdown.single(
                  items: cityList.map((value) {
                    return (DropdownMenuItem(
                      child: Text(value["name"]),
                      value: value["isoCode"],
                    ));
                  }).toList(),
                  value: selectedCity,
                  hint: "Select City",
                  isCaseSensitiveSearch: false,
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                  searchHint: "Select City",
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  dialogBox: true,
                  displayClearIcon: false,
                  isExpanded: true,
                ),
              ),
              MyTextFormField(
                  controller: txtStreetName,
                  lable: "Street Name",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Street Name";
                    }
                    return null;
                  },
                  hintText: "Enter Street Name"),
              MyTextFormField(
                  controller: txtStreetAddress,
                  lable: "Street Address",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Street Address";
                    }
                    return null;
                  },
                  hintText: "Enter Street Address"),
              MyTextFormField(
                  controller: txtZipCode,
                  lable: "ZipCode",
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter ZipCode";
                    }
                    return null;
                  },
                  hintText: "Enter ZIP Code"),
              MyButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SetupWings(),
                            type: PageTransitionType.rightToLeft));
                  },
                  title: "Submit"),
            ],
          ),
        ),
      ),
    );
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
          "societyName": txtSocName.text,
          "totalWings": "",
          "country": "india",
          "state": "gujarat",
          "city": "surat",
          "lat": "21.0541351",
          "long": "72.151513",
          "completeAddress": txtStreetName.text + " " + txtStreetAddress.text,
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

            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
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
        isCountryLoading = true;
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
            print("------------------------>$countryList");
            setState(() {
              isCountryLoading = false;
              countryList = responseData.Data;
            });
          } else {
            print(responseData);
            setState(() {
              isCountryLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isCountryLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isCountryLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

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
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            print(responseData);
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _getAllstate(var selectedCountry) async {
    try {
      setState(() {
        isStateLoading = true;
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
            setState(() {
              isStateLoading = false;
            });
          } else {
            print(responseData);
            setState(() {
              isStateLoading = false;
            });
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isStateLoading = false;
          });
          //LoadingIndicator.close(context);
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isStateLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _getAllCity({var selectedCountry, var selectedState}) async {
    try {
      setState(() {
        isCityLoading = true;
      });
      //LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "countryCode": selectedCountry,
          "stateCode": selectedState,
        };
        Services.responseHandler(
          apiName: "api/admin/getCity",
          body: body,
        ).then((responseData) {
          if (responseData.Data.length > 0) {
            print("getAllCity -- >${responseData.Data}");
            cityList = responseData.Data;
            setState(() {
              isCityLoading = false;
            });
          } else {
            setState(() {
              isCityLoading = false;
            });
            print(responseData);
            Fluttertoast.showToast(
                msg: "${responseData.Message}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                // textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((error) {
          setState(() {
            isCityLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Error $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              // textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {
      setState(() {
        isCityLoading = false;
      });
      //LoadingIndicator.close(context);
      Fluttertoast.showToast(
          msg: "You aren't connected to the Internet !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
