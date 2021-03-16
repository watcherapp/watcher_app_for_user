
   bool isNumeric(var str) {
    if (str == "") {
      return false;
    }
    return int.tryParse(str) != null;
  }
