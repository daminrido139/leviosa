import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/services/calendar_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/ui/drawer_page/drawer_page.dart';
import 'package:leviosa/widgets/calender/day_date_box.dart';
import 'package:leviosa/widgets/calender/day_title_box.dart';
import 'package:leviosa/widgets/calender/event_cell_builder.dart';
import 'package:leviosa/widgets/calender/month_cell_builder.dart';
import 'package:leviosa/widgets/calender/week_day_box.dart';
import 'package:leviosa/widgets/calender/week_number_box.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final EventController eventController = EventController();
  final GlobalKey<MonthViewState> monthViewKey = GlobalKey();
  final GlobalKey<WeekViewState> weekViewKey = GlobalKey();
  final GlobalKey<DayViewState> dayViewKey = GlobalKey();
  final GlobalKey<ScaffoldState> key = GlobalKey();

  //////////////////////////////////////////////////////////
  List<Widget Function()> calendarViews = [];
  int selectedView = 0; // default to day span

  /////////// Day Span Vars ////////////////////////

  String displayDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

  //////////////////////////////////////////////////

  void updateSpan(int value) {
    selectedView = value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeCalendar();
  }

  @override
  void dispose() {
    super.dispose();
    eventController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      key: key,
      drawer: const DrawerPage(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 60,
        leading: InkWell(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              DefaultDp(name: context.read<UserCubit>().state.name, size: 40),
            ],
          ),
        ),
        title: Row(
          children: [
            const LeviosaText(
              "Calender",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            LeviosaText(
              displayDate,
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
      body: Column(
        children: [
          periodBtn(width),
          Expanded(child: calendarViews[selectedView]()),
        ],
      ),
    );
  }

  /////////////////////// Top Btn ///////////////////////////////
  ///
  ///
  ///
  ///
  ///
  Widget gradientSelectionBtn(String label, int value, double width) {
    return MaterialButton(
      minWidth: width * 0.29,
      onPressed: () {
        updateSpan(value);
        changeDate(DateTime.now(), 0);
      },
      child: LeviosaText(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: selectedView == value ? Colors.black : Colors.grey,
        ),
      ),
    );
  }

  Widget segmentLine() {
    return Container(
      width: 1,
      height: 24,
      color: const Color.fromRGBO(0, 0, 0, 0.25),
    );
  }

  Widget periodBtn(double width) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14, top: 12),
      height: 34,
      width: width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xfff5f5f5)),
      child: Row(
        children: [
          //////////// Day //////////
          const Spacer(),
          gradientSelectionBtn('Day', 0, width),
          const Spacer(),
          segmentLine(),
          /////////////////////////////

          //////////// Week //////////////
          const Spacer(),
          gradientSelectionBtn('Week', 1, width),
          const Spacer(),
          segmentLine(),

          ///////////// Month /////////////////

          const Spacer(),
          gradientSelectionBtn('Month', 2, width),
          const Spacer(),
          /////////////////////////////////////
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///

  //////////////////////////////  Day Span /////////////////////////////
  ///
  ///
  ///
  ///
  ///

  Widget daySpanReCenterBtn() {
    return Positioned(
      bottom: 10,
      left: 40,
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(230, 75, 224, 247),
        radius: 20,
        child: IconButton(
          iconSize: 20,
          icon: const Icon(Icons.gps_fixed),
          onPressed: () async {
            // await daySpanScrollController.scrollTo(
            //   index: DateTime.now().difference(firstDate).inHours,
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.bounceInOut,
            // );
            // daySpanScrolledPos = 0;
            // setState(() {});
          },
        ),
      ),
    );
  }

  String getDaySpanTime(int index) {
    int hour = index % 12;
    hour = hour == 0 ? 12 : hour;
    String hr = hour.toString().padLeft(2, '0');
    final meridian = index % 24 < 12 ? 'AM' : 'PM';
    return '$hr:00 $meridian';
  }

  /////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  //////////////////////////////////////////////////////////////////////////////

  Widget timelineBuilder(DateTime date) {
    final timeString = CalendarServices.time12FromDate(date.hour, date.minute);
    return Transform.translate(
      offset: const Offset(0, -7.5),
      child: Padding(
        padding: const EdgeInsets.only(right: 7.0),
        child: LeviosaText(
          timeString,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget monthView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: MonthView(
        controller: eventController,
        borderColor:
            isLightMode(context) ? Colors.grey.shade400 : Colors.grey.shade600,
        hideDaysNotInMonth: true,
        key: monthViewKey,
        headerBuilder: (date) => const SizedBox(),
        cellAspectRatio: 1.35,
        weekDayBuilder: (day) => WeekDayBox(
          day: day,
        ),
        onPageChange: changeDate,
        cellBuilder: (date, event, isToday, isInMonth, hideDaysNotInMonth) =>
            MonthCellBuilder(
          date: date,
          shouldHighlight: isToday,
          backgroundColor: isInMonth
              ? (isLightMode(context)
                  ? const Color.fromRGBO(243, 242, 248, 1)
                  : const Color(0xFF171717))
              : (isLightMode(context)
                  ? Colors.grey.shade300
                  : const Color.fromARGB(255, 51, 51, 51)),
          events: event,
          isInMonth: isInMonth,
          // onTileTap: widget.onEventTap,
          // dateStringBuilder: widget.dateStringBuilder,
          titleColor: isLightMode(context) ? Colors.black : Colors.white,
          hideDaysNotInMonth: hideDaysNotInMonth,
        ),
      ),
    );
  }

  Widget dayView() {
    return DayView(
      backgroundColor: isLightMode(context) ? null : const Color(0xFF171717),
      keepScrollOffset: true,
      scrollOffset: 800,
      heightPerMinute: 2,
      controller: eventController,
      key: dayViewKey,
      onDateTap: (date) {},
      dayTitleBuilder: (date) => DayTitleBox(dateTime: date),
      onPageChange: changeDate,
      liveTimeIndicatorSettings:
          const LiveTimeIndicatorSettings(color: Colors.blue),
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) =>
          EventCellBuilder(
        date: date,
        events: events,
        boundary: boundary,
        startDuration: startDuration,
        endDuration: endDuration,
      ),
      timeLineBuilder: (date) => timelineBuilder(date),
    );
  }

  Widget weekView() {
    return WeekView(
      backgroundColor:
          isLightMode(context) ? Colors.white : const Color(0xFF171717),
      keepScrollOffset: true,
      heightPerMinute: 2,
      scrollOffset: 800,
      weekTitleHeight: 75,
      headerStyle: const HeaderStyle(
        decoration: BoxDecoration(color: Colors.grey),
        headerPadding: EdgeInsets.symmetric(vertical: 10),
        headerTextStyle: TextStyle(fontSize: 17, color: Colors.white),
      ),
      weekNumberBuilder: (date) => WeekNumberBox(date: date),
      weekDayBuilder: (date) => DayDateBox(dateTime: date),
      controller: eventController,
      key: weekViewKey,
      weekPageHeaderBuilder: (startDate, endDate) => const SizedBox(),
      onPageChange: changeDate,
      liveTimeIndicatorSettings:
          const LiveTimeIndicatorSettings(color: Colors.blue),
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) =>
          EventCellBuilder(
        date: date,
        events: events,
        boundary: boundary,
        startDuration: startDuration,
        endDuration: endDuration,
      ),
      timeLineBuilder: timelineBuilder,
    );
  }

  void initializeCalendar() {
    calendarViews = [
      dayView,
      weekView,
      monthView,
    ];
  }

  void previousPage() {
    if (selectedView == 0) {
      monthViewKey.currentState!.previousPage();
    } else if (selectedView == 1) {
      dayViewKey.currentState!.previousPage();
    } else {
      weekViewKey.currentState!.previousPage();
    }
  }

  void nextPage() {
    if (selectedView == 0) {
      monthViewKey.currentState!.nextPage();
    } else if (selectedView == 1) {
      dayViewKey.currentState!.nextPage();
    } else {
      weekViewKey.currentState!.nextPage();
    }
  }

  void goToToday() {
    final ctd = DateTime.now();
    if (selectedView == 0) {
      monthViewKey.currentState!.animateToMonth(ctd);
    } else if (selectedView == 1) {
      dayViewKey.currentState!.animateToDate(ctd);
    } else {
      weekViewKey.currentState!.animateToWeek(ctd);
    }
  }

  void changeDate(DateTime date, int _) {
    final dateTime = DateFormat('MMMM d, yyyy').format(date);
    if (dateTime != displayDate) {
      displayDate = dateTime;
      setState(() {});
    }
  }
}
