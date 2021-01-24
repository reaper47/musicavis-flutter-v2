import 'package:flutter/material.dart';

import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/repository/models/practice.dart';

final calendarProvider = StateNotifierProvider((_) => CalendarEvents());

class CalendarEvent {
  final int id;
  final String instrument;
  final DateTime datetime;
  final String practiceTime;
  final Color color;

  const CalendarEvent(
    this.id, {
    this.instrument,
    this.datetime,
    this.practiceTime,
    this.color,
  });
}

class CalendarEvents extends StateNotifier<Map<DateTime, List<CalendarEvent>>> {
  CalendarEvents() : super({}) {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, 1);
    final last = DateTime(now.year, now.month + 1, 0);
    refreshMonth(first, last);
  }

  refreshMonth(DateTime first, DateTime last) {
    Map<DateTime, List<CalendarEvent>> eventsMap = {};
    Hive.box<Practice>(PRACTICES_BOX)
        .values
        .where((x) => x.datetime.isAfter(first) && x.datetime.isBefore(last))
        .map(_toCalendarEvent)
        .forEach((event) => _addToMap(eventsMap, event));
    state = eventsMap;
  }

  CalendarEvent _toCalendarEvent(Practice practice) {
    final int totalMinutes =
        practice.exercises.fold(0, (prev, current) => prev + current.minutes);
    final numHours = totalMinutes ~/ 60;
    final numMinutes = totalMinutes - numHours * 60;

    final date = practice.datetime;
    return CalendarEvent(
      practice.id,
      instrument: practice.instrument,
      datetime: DateTime(date.year, date.month, date.day),
      practiceTime: "${numHours}h${numMinutes.toString().padLeft(2, '0')}",
      color: Colors.primaries[practice.id % Colors.primaries.length],
    );
  }

  _addToMap(Map<DateTime, List<CalendarEvent>> eventsMap, CalendarEvent event) {
    if (eventsMap[event.datetime]?.isEmpty ?? true) {
      eventsMap[event.datetime] = [];
    }
    eventsMap[event.datetime].add(event);
  }

  List getSelectedEvents(DateTime day) {
    day = DateTime(day.year, day.month, day.day);
    if (state.containsKey(day)) {
      return state[day];
    }
    return [];
  }
}
