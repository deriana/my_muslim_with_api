// calendar_widget.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<DateTime> onPageChanged;

  const CalendarWidget({
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
    super.key,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(widget.selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          widget.onDaySelected(selectedDay);
          _focusedDay = focusedDay;
        });
      },
      onPageChanged: widget.onPageChanged,
      availableCalendarFormats: const {
        CalendarFormat.week: '1 Week',  // Change here to week view
      },
      firstDay: DateTime.utc(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - DateTime.now().weekday + 1, // Start of this week (Monday)
      ),
      lastDay: DateTime.utc(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - DateTime.now().weekday + 7, // End of this week (Sunday)
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white),
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white),
        weekendStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(color: Colors.black),
        selectedTextStyle: const TextStyle(color: Colors.black),
        defaultTextStyle: const TextStyle(color: Colors.white),
        weekendTextStyle: const TextStyle(color: Colors.white),
      ),
      calendarFormat: CalendarFormat.week,  // Change to one-week view
    );
  }
}
