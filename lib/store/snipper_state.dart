import 'package:flutter/material.dart';

//Not Used
class SpinnerState extends ChangeNotifier {
  bool showSpinner = false;

  bool get getSpinnerState {
    return showSpinner;
  }

  void toggleSpinner() {
    showSpinner = !showSpinner;
    notifyListeners();
  }
}
