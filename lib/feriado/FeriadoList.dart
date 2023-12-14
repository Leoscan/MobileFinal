import 'Feriado.dart';

class FeriadoList {
  List<Feriado>? feriadoList;

  FeriadoList({this.feriadoList});

  FeriadoList.fromJson(List<dynamic> parsedJson) {
    feriadoList = [];
    parsedJson.forEach((v) {
      feriadoList!.add(Feriado.fromJson(v));
    });
  }
}
