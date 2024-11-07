import 'package:flutter/material.dart';
import 'package:test_run/pt_schedule_picker_widget/schedule_model.dart';
import 'package:test_run/pt_schedule_picker_widget/schedule_picker_controller.dart';
import 'package:test_run/pt_schedule_picker_widget/schedule_ratio_model.dart';

import '../dummy data/dummy data.dart';

class StaticTime extends StatelessWidget {
  final String time;
  final bool isAm;

  const StaticTime({super.key, required this.time, required this.isAm});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [TextSpan(text: time, style: const TextStyle(color: Colors.black87, fontSize: 18)), TextSpan(text: isAm ? "AM" : "PM", style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w300, fontSize: 9))]),
    );
  }
}

class TimeScheduleWidget extends StatefulWidget {
  final ScheduleModel scheduleModel;
  final SchedulePickerController schedulePickerController;

  const TimeScheduleWidget({super.key, required this.scheduleModel, required this.schedulePickerController});

  @override
  State<TimeScheduleWidget> createState() => _TimeScheduleWidgetState();
}

class _TimeScheduleWidgetState extends State<TimeScheduleWidget> {
  final int millisecondsInADay = 86400000;
  List<ScheduleRatioModel> bookedTimes = [];
  List<ScheduleRatioModel> workingTimes = [];
  List<ScheduleRatioModel> availableTimes = [];

  void initScheduleObjects() {
    var maxOfThatDay = widget.scheduleModel.currentDate.millisecondsSinceEpoch;

    for (var element in widget.scheduleModel.workingHours) {
      workingTimes.add(ScheduleRatioModel(startPercent: ((element.start.millisecondsSinceEpoch - maxOfThatDay) / millisecondsInADay) * 100, endPercent: ((element.end.millisecondsSinceEpoch - maxOfThatDay) / millisecondsInADay) * 100, viewModeOn: true));
    }

    for (var element in widget.scheduleModel.bookedTimes) {
      bookedTimes.add(ScheduleRatioModel(startPercent: ((element.start.millisecondsSinceEpoch - maxOfThatDay) / millisecondsInADay) * 100, endPercent: ((element.end.millisecondsSinceEpoch - maxOfThatDay) / millisecondsInADay) * 100, viewModeOn: true, bookedStatus: true));
    }

    for (var element in widget.scheduleModel.availableTimes) {
      availableTimes.add(ScheduleRatioModel(startPercent: ((element.start.millisecondsSinceEpoch - maxOfThatDay) / millisecondsInADay) * 100, endPercent: ((element.end.millisecondsSinceEpoch - maxOfThatDay) / millisecondsInADay) * 100, viewModeOn: true, bookedStatus: false, dateTimeRange: DateTimeRange(start: element.start, end: element.end)));
    }

    blankModifier();
  }

  void blankModifier() {
    workingTimes.sort((a, b) {
      return a.startPercent.compareTo(b.startPercent);
    });
    bookedTimes.sort((a, b) {
      return a.startPercent.compareTo(b.startPercent);
    });

    availableTimes.sort((a, b) {
      return a.startPercent.compareTo(b.startPercent);
    });

    /// Setting up work schedule

    List<ScheduleRatioModel> temp = [];

    if (workingTimes.isNotEmpty && workingTimes.first.startPercent > 0) {
      temp.add(ScheduleRatioModel(
        startPercent: 0,
        endPercent: workingTimes.first.startPercent - 0.001,
        viewModeOn: false,
      ));
    }

    for (int i = 0; i < workingTimes.length - 1; i++) {
      var current = workingTimes[i];
      var next = workingTimes[i + 1];

      if (current.endPercent < next.startPercent) {
        temp.add(ScheduleRatioModel(
          startPercent: current.endPercent + 0.001,
          endPercent: next.startPercent - 0.001,
          viewModeOn: false,
        ));
      }
    }

    if (workingTimes.isNotEmpty && workingTimes.last.endPercent < 100) {
      temp.add(ScheduleRatioModel(
        startPercent: workingTimes.last.endPercent + 0.001,
        endPercent: 100,
        viewModeOn: false,
      ));
    }

    workingTimes.addAll(temp);
    workingTimes.sort((a, b) {
      return a.startPercent.compareTo(b.startPercent);
    });

    /// Setting up booking schedule

    List<ScheduleRatioModel> tempBooking= [];

    if (bookedTimes.isNotEmpty && bookedTimes.first.startPercent > 0) {
      tempBooking.add(ScheduleRatioModel(
        startPercent: 0,
        endPercent: bookedTimes.first.startPercent - 0.001,
        viewModeOn: false,
      ));
    }

    for (int i = 0; i < bookedTimes.length - 1; i++) {
      var current = bookedTimes[i];
      var next = bookedTimes[i + 1];

      if (current.endPercent < next.startPercent) {
        tempBooking.add(ScheduleRatioModel(
          startPercent: current.endPercent + 0.001,
          endPercent: next.startPercent - 0.001,
          viewModeOn: false,
        ));
      }
    }

    if (bookedTimes.isNotEmpty && bookedTimes.last.endPercent < 100) {
      tempBooking.add(ScheduleRatioModel(
        startPercent: bookedTimes.last.endPercent + 0.001,
        endPercent: 100,
        viewModeOn: false,
      ));
    }

    bookedTimes.addAll(tempBooking);
    bookedTimes.sort((a, b) {
      return a.startPercent.compareTo(b.startPercent);
    });


    ///Setyp booking times


    List<ScheduleRatioModel> tempAvailable = [];

    if (availableTimes.isNotEmpty && availableTimes.first.startPercent > 0) {
      tempAvailable.add(ScheduleRatioModel(
        startPercent: 0,
        endPercent: availableTimes.first.startPercent - 0.001,
        viewModeOn: false,
      ));
    }

    for (int i = 0; i < availableTimes.length - 1; i++) {
      var current = availableTimes[i];
      var next = availableTimes[i + 1];

      if (current.endPercent < next.startPercent) {
        tempAvailable.add(ScheduleRatioModel(
          startPercent: current.endPercent + 0.001,
          endPercent: next.startPercent - 0.001,
          viewModeOn: false,
        ));
      }
    }

    if (availableTimes.isNotEmpty && availableTimes.last.endPercent < 100) {
      tempAvailable.add(ScheduleRatioModel(
        startPercent: availableTimes.last.endPercent + 0.001,
        endPercent: 100,
        viewModeOn: false,
      ));
    }

    availableTimes.addAll(tempAvailable);
    availableTimes.sort((a, b) {
      return a.startPercent.compareTo(b.startPercent);
    });



  }

  void selectSchedule(ScheduleRatioModel schedule){
    for(var element in availableTimes)
      {
        if(element == schedule)
          {
            element.bookedStatus = true;
          }
        else
          {
            element.bookedStatus = false;
          }
      }
    widget.schedulePickerController.setDateTimeRange(schedule.dateTimeRange!);
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState

    initScheduleObjects();

    print(workingTimes);
    print("------------------");
    print(bookedTimes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StaticTime(time: "12", isAm: true),
              StaticTime(time: "3", isAm: true),
              StaticTime(time: "6", isAm: true),
              StaticTime(time: "9", isAm: true),
              StaticTime(time: "12", isAm: false),
              StaticTime(time: "3", isAm: false),
              StaticTime(time: "6", isAm: false),
              StaticTime(time: "9", isAm: false),
              StaticTime(time: "12", isAm: false),
            ],
          ),
          const SizedBox(height: 10),
          ClipRect(
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(5)),
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Row(
                    children: workingTimes.map(
                      (e) {
                        print(((size.width - 30) * (e.endPercent / 100)) - (size.width - 30) * (e.startPercent / 100));
                        return Container(
                          width: ((size.width - 30) * (e.endPercent / 100)) - (size.width - 30) * (e.startPercent / 100),
                          height: 30,
                          decoration: BoxDecoration(
                            color: e.viewModeOn ? Colors.grey.shade300 : Colors.transparent,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Row(
                    children: bookedTimes.map(
                      (e) {
                        print(((size.width - 30) * (e.endPercent / 100)) - (size.width - 30) * (e.startPercent / 100));
                        return Container(
                          width: ((size.width - 30) * (e.endPercent / 100)) - (size.width - 30) * (e.startPercent / 100),
                          height: 30,
                          decoration: BoxDecoration(
                            color: e.viewModeOn && e.bookedStatus! ? Colors.black.withOpacity(0.7) : Colors.transparent,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),

                Material(
                  borderRadius: BorderRadius.circular(5),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: Row(
                    children: availableTimes.map(
                          (e) {
                        print(((size.width - 30) * (e.endPercent / 100)) - (size.width - 30) * (e.startPercent / 100));
                        return Container(
                          width: ((size.width - 30) * (e.endPercent / 100)) - (size.width - 30) * (e.startPercent / 100),
                          height: 30,
                          decoration: BoxDecoration(
                            color: e.viewModeOn &&  e.bookedStatus! ? customGreen: Colors.transparent,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            children: availableTimes.map(
              (e) {
                if(e.viewModeOn)
                  {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ClipRect(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: (){
                            selectSchedule(e);
                          },
                          child: Chip(
                            clipBehavior: Clip.hardEdge,
                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            label: Text(
                              getCurrentTimeIn12HourFormat(dateTime:  e.dateTimeRange!.start),
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                            backgroundColor: e.bookedStatus!? customGreen: Colors.transparent,
                          ),
                        ),
                      ),
                    );
                  }
                else
                  {
                    return Container(width: 0,);
                  }
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
