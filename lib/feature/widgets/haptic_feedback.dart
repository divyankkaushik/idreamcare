import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticFeedback {
  var _type = FeedbackType.error;

  void errorVibration() {
    Vibrate.feedback(_type);
  }
}
