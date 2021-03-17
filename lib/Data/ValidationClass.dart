bool isNumeric(var str) {
  if (str == "") {
    return false;
  }
  return int.tryParse(str) != null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty)
    return "Email can't be empty";
  else if (!regex.hasMatch(value))
    return "Invalid Email";
  else
    return null;
}

String validatePassword(String value) {
  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8}$';
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) {
    return "Password can't be empty";
  } else if (!regExp.hasMatch(value)) {
    return "Password must contain";
  } else {
    return null;
  }
}

String emptyValidation(String value) {
  if (value.isEmpty) {}
}
