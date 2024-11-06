import 'package:flutter/material.dart';
import 'package:test_run/pt_schedule_picker_widget/schedule_model.dart';

class SchedulePickerController with ChangeNotifier{
  DateTimeRange? dateTimeRange;

  bool hasDate() => dateTimeRange != null;

  void setDateTimeRange(DateTimeRange value) {
    dateTimeRange = value;
    notifyListeners();
  }
}