import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import 'package:apirequest/conexao/EndPoints.dart';

class Event {
  final String title;
  const Event(this.title);
  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

Map<DateTime, List<Event>> _kEventSource = {};
Future<void> initializeEventSource() async {
  List<Map<String, dynamic>> feriadoList = await collectFeriados();
  _kEventSource = Map.fromIterable(feriadoList,
      key: (item) {
        DateTime date = DateTime.parse(item['date']).toLocal();
        ;
        return date;
      },
      value: (item) => [Event(item['localName'])]);
  kEvents.addAll(_kEventSource);
  initializeSource();
}

Map<DateTime, List<Event>> _Source = {};
Future<void> initializeSource() async {
  List<Map<String, dynamic>> eventosList = await collectEvents();
  _Source = Map.fromIterable(eventosList,
      key: (item) {
        DateTime date = DateTime.parse(item['data']).toLocal();
        ;
        return date;
      },
      value: (item) => [Event(item['model'])]);
  kEvents.addAll(_Source);
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
