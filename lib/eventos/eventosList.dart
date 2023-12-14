import 'eventos.dart';

class EventosList {
  List<Eventos>? evList;

  EventosList({this.evList});

  EventosList.fromJson(List<dynamic>? parsedJson) {
    evList = [];
    parsedJson!.forEach((v) {
      evList!.add(Eventos.fromJson(v));
    });
  }
}
