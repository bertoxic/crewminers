import 'package:flutter/foundation.dart';

class UtilityProvider extends ChangeNotifier {
  bool _isCustomPopUp = false;

  bool get isCustomPopUp => _isCustomPopUp;

  set isCustomPopUp(bool value) {
    if (_isCustomPopUp != value) {
      _isCustomPopUp = value;
      notifyListeners(); // Notify listeners about the change
    }
  }
}
