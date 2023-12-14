import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

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

Map<DateTime, List<Event>> _kEventSource = {};
Future<List<Map<String, dynamic>>> feriados() async {
  String url = 'https://date.nager.at/api/v3/PublicHolidays/2023/BR';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    print("response is 200");
    List<Map<String, dynamic>> jsonData =
        List<Map<String, dynamic>>.from(json.decode(response.body));
    //print(jsonData);
    return jsonData;
  }
  return [];
}

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

Future<void> initializeEventSource() async {
  List<Map<String, dynamic>> feriadoList = await feriados();
  _kEventSource = Map.fromIterable(feriadoList,
      key: (item) {
        DateTime date = DateTime.parse(item['date']).toLocal();
        ;
        return date;
      },
      value: (item) => [Event(item['localName'])]);
  kEvents.addAll(_kEventSource);
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
