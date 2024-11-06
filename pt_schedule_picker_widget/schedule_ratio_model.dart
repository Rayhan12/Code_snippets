import 'package:flutter/material.dart';

class ScheduleRatioModel{
  final DateTimeRange? dateTimeRange;
  final double startPercent;
  final double endPercent;
  bool viewModeOn = false;
  bool? bookedStatus = false;

  ScheduleRatioModel({required this.startPercent , required this.endPercent, required this.viewModeOn , this.bookedStatus, this.dateTimeRange});

  @override
  String toString() {
    return 'ScheduleRatioModel{startPercent: $startPercent, endPercent: $endPercent, viewModeOn: $viewModeOn, bookedStatus: $bookedStatus}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is ScheduleRatioModel && runtimeType == other.runtimeType && dateTimeRange == other.dateTimeRange && startPercent == other.startPercent && endPercent == other.endPercent && viewModeOn == other.viewModeOn && bookedStatus == other.bookedStatus;

  @override
  int get hashCode => dateTimeRange.hashCode ^ startPercent.hashCode ^ endPercent.hashCode ^ viewModeOn.hashCode ^ bookedStatus.hashCode;
}