import 'dart:convert';

class ScheduleModel {
  DateTime currentDate;
  List<AvailableTime> workingHours;
  List<AvailableTime> bookedTimes;
  List<AvailableTime> availableTimes;

  ScheduleModel({
    required this.currentDate,
    required this.workingHours,
    required this.bookedTimes,
    required this.availableTimes,
  });

  factory ScheduleModel.fromRawJson(String str) => ScheduleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    currentDate: DateTime.parse(json["current_date"]),
    workingHours: List<AvailableTime>.from(json["working_hours"].map((x) => AvailableTime.fromJson(x))),
    bookedTimes: List<AvailableTime>.from(json["booked_times"].map((x) => AvailableTime.fromJson(x))),
    availableTimes: List<AvailableTime>.from(json["available_times"].map((x) => AvailableTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_date": currentDate.toIso8601String(),
    "working_hours": List<dynamic>.from(workingHours.map((x) => x.toJson())),
    "booked_times": List<dynamic>.from(bookedTimes.map((x) => x.toJson())),
    "available_times": List<dynamic>.from(availableTimes.map((x) => x.toJson())),
  };
}

class AvailableTime {
  DateTime start;
  DateTime end;

  AvailableTime({
    required this.start,
    required this.end,
  });

  factory AvailableTime.fromRawJson(String str) => AvailableTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "start": start.toIso8601String(),
    "end": end.toIso8601String(),
  };
}
