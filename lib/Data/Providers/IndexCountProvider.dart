import 'package:flutter/cupertino.dart';

class IndexCountProvider with ChangeNotifier {
  int _bottomBarCurrentIndex = 2;
  int _stepCurrentIndex = 0;

  /* For BottomNavigationBar Index */

  get bottomBarCurrentIndex => _bottomBarCurrentIndex;
  set bottomBarCurrentIndex(int index) {
    _bottomBarCurrentIndex = index;

    print(_bottomBarCurrentIndex);
    notifyListeners();
  }

  /* For StepCurrent Index */

  get stepCurrentIndex => _stepCurrentIndex;
  set stepCurrentIndex(int index) {
    _stepCurrentIndex = index;
    print(_stepCurrentIndex);
    notifyListeners();
  }

  backButton() {
    if (_stepCurrentIndex != 0) {
      _stepCurrentIndex--;
    }
    notifyListeners();
  }
}
