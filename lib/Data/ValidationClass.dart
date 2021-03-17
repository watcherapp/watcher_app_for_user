bool isNumeric(var str) {
  if (str == "") {
    return false;
  }
  return int.tryParse(str) != null;
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return "Password can't be empty";
  } else if (value.length < 8) {
    return "Password should be atleast 8 characters";
  } else if (value.isValidPassword()) {
    return "Password Upercase Lowercase missing";
  } else
    return null;
}
