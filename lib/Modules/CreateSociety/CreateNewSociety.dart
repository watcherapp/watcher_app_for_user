import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:watcher_app_for_user/CommonWidgets/LoadingIndicator.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyButton.dart';
import 'package:watcher_app_for_user/CommonWidgets/MyTextFormField.dart';
import 'package:watcher_app_for_user/Constants/fontStyles.dart';
import 'package:watcher_app_for_user/Data/Services.dart';
import 'package:watcher_app_for_user/Data/SharedPrefs.dart';
import 'package:watcher_app_for_user/Modules/CreateSociety/SetupWings.dart';

class CreateNewSociety extends StatefulWidget {
  @override
  _CreateNewSocietyState createState() => _CreateNewSocietyState();
}

class _CreateNewSocietyState extends State<CreateNewSociety> {
  String selectedCountry = "";
  String selectedState = "";
  String selectedCity = "";
  String selectedCountryName = "";
  String selectedStateName = "";
  String selectedCityName = "";
  String latitude, longitude;
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
  String societyId = "";
  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode societyName = new FocusNode();
  FocusNode wingNumber = new FocusNode();
  FocusNode streetName = new FocusNode();
  FocusNode streetAddress = new FocusNode();
  FocusNode zipcode = new FocusNode();
  FocusNode submit = new FocusNode();
  @override
  void initState() {
    super.initState();
    _getAllSocietyCategory();
    _getAllCountries();
  }

  @override
  void dispose() {
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      societyName.dispose();
      wingNumber.dispose();
      streetName.dispose();
      streetAddress.dispose();
      zipcode.dispose();
      submit.dispose();
    }
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
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Society Type",
                    style: fontConstants.formFieldLabel),
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
                    focusNode: societyName,
                    controller: txtSocName,
                    lable: "Society Name",
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Society Name";
                      }
                      return null;
                    },
                    onFieldSubmitted: (term) {
                      societyName.unfocus();
                      FocusScope.of(context).requestFocus(wingNumber);
                    },
                    hintText: "Enter Society Name"),
                MyTextFormField(
                    focusNode: wingNumber,
                    controller: txtWingNumber,
                    textInputAction: TextInputAction.done,
                    lable: "Total Wings or Apartment buildings",
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Total Wings or Apartment buildings";
                      }
                      return null;
                    },
                    onFieldSubmitted: (term) {
                      wingNumber.unfocus();
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
                        value: value["isoCode"] + "@" + value["name"],
                      ));
                    }).toList(),
                    value: selectedCountry,
                    hint: "Select Country",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                    searchHint: "Select Country",
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value.toString().split("@")[0];
                        selectedCountryName = value.toString().split("@")[1];
                      });
                      _getAllstate(selectedCountry);
                      print(selectedCountryName);
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
                              value: value["isoCode"] + "@" + value["name"],
                            ));
                          }).toList(),
                          value: selectedState,
                          hint: "Select State",
                          isCaseSensitiveSearch: false,
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                          searchHint: "Select State",
                          onChanged: (value) {
                            setState(() {
                              selectedState = value.toString().split("@")[0];
                              selectedStateName =
                                  value.toString().split("@")[1];
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
                isCityLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: Colors.grey[200],
                        ),
                        child: SearchableDropdown.single(
                          items: cityList.map((value) {
                            return (DropdownMenuItem(
                              child: Text(value["name"] ?? ""),
                              value: value,
                            ));
                          }).toList(),
                          value: selectedCity,
                          hint: "Select City",
                          isCaseSensitiveSearch: false,
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                          searchHint: "Select City",
                          onChanged: (value) {
                            setState(() {
                              selectedCityName = value["name"];
                              latitude = value["latitude"];
                              longitude = value["longitude"];
                            });
                            print(selectedCityName +
                                " " +
                                latitude +
                                " " +
                                longitude);
                          },
                          dialogBox: true,
                          displayClearIcon: false,
                          isExpanded: true,
                        ),
                      ),
                MyTextFormField(
                    focusNode: streetName,
                    controller: txtStreetName,
                    textInputAction: TextInputAction.next,
                    lable: "Street Name",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Street Name";
                      }
                      return null;
                    },
                    onFieldSubmitted: (term) {
                      streetName.unfocus();
                      FocusScope.of(context).requestFocus(streetAddress);
                    },
                    hintText: "Enter Street Name"),
                MyTextFormField(
                    controller: txtStreetAddress,
                    focusNode: streetAddress,
                    textInputAction: TextInputAction.next,
                    lable: "Street Address",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter Street Address";
                      }
                      return null;
                    },
                    onFieldSubmitted: (term) {
                      streetAddress.unfocus();
                      FocusScope.of(context).requestFocus(zipcode);
                    },
                    hintText: "Enter Street Address"),
                MyTextFormField(
                    focusNode: zipcode,
                    controller: txtZipCode,
                    textInputAction: TextInputAction.next,
                    lable: "ZipCode",
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Enter ZipCode";
                      }
                      return null;
                    },
                    onFieldSubmitted: (term) {
                      zipcode.unfocus();
                      FocusScope.of(context).requestFocus(submit);
                    },
                    hintText: "Enter ZIP Code"),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: MyButton(
                      focusNode: submit,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _createSociety();
                        }
                      },
                      title: "Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createSociety() async {
    try {
      LoadingIndicator.show(context);
      final internetResult = await InternetAddress.lookup('google.com');
      if (internetResult.isNotEmpty &&
          internetResult[0].rawAddress.isNotEmpty) {
        var body = {
          "secretaryId": "${sharedPrefs.memberId}",
          "societyName": txtSocName.text,
          "totalWings": txtWingNumber.text,
          "country": selectedCountryName,
          "state": selectedStateName,
          "city": selectedCityName,
          "lat": latitude,
          "long": longitude,
          "completeAddress": txtStreetName.text + " " + txtStreetAddress.text,
          "categoryId": selectedSocietyType
        };
        print("$body");
        Services.responseHandler(
                apiName: "api/society/createSociety", body: body)
            .then((responseData) {
          if (responseData.Data.length > 0) {
            print(responseData.Data);
            LoadingIndicator.close(context);
            setState(() {
              societyId = responseData.Data[0]["_id"];
            });
            print(societyId);
            Navigator.push(
                context,
                PageTransition(
                    child: SetupWings(
                        wingsCount: int.parse(txtWingNumber.text),
                        societyId: societyId),
                    type: PageTransitionType.rightToLeft));
          } else {
            print(responseData);
            LoadingIndicator.close(context);
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
          LoadingIndicator.close(context);
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
      LoadingIndicator.close(context);
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
          print(responseData.Data.length);
          if (responseData.Data.length > 0) {
            print("getAllstate -- >${responseData.Data}");
            stateList = responseData.Data;
            setState(() {
              isStateLoading = false;
            });
          } else {
            print(responseData.Message);
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
