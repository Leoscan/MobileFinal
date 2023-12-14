import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:apirequest/feriado/FeriadoList.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:apirequest/eventos/eventosList.dart';
import 'package:apirequest/eventos/eventos.dart';

const String _noValueGiven = "";

String feriados = "https://date.nager.at/api/v3/PublicHolidays/2023/BR";

Future<FeriadoList> getferiadoListData() async {
  final response = await http.get(
    Uri.parse(feriados),
  );
  return FeriadoList.fromJson(json.decode(response.body));
}

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Widget loadingView() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}

Widget noDataView(String msg) => Center(
      child: Text(
        msg,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
    );

String eventoGet = "http://10.0.2.2/list";
String eventoPost = "http://10.0.2.2/store";

Future<EventosList> geteventoListData([String id = _noValueGiven]) async {
  final response = await http.get(
    Uri.parse(eventoGet),
  );
  return EventosList.fromJson(json.decode(response.body));
}

Future<http.Response> createPost(Eventos evento, String url) async {
  final response = await http.post(Uri.parse(eventoPost),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: jsonEncode(evento));
  return response;
}

EventosList postFromJson(String str) {
  final jsonData = json.decode(str);
  return EventosList.fromJson(jsonData);
}

Future<EventosList> callAPI(Eventos evento) async {
  //eventoModel evento = eventoModel(id: "15", model: "teste", price: 17.0);
  print(evento.toJson());
  //EventosList.fromJson(json.decode(response.body));
  createPost(evento, eventoPost).then((response) {
    print(response.body);
    if (response.statusCode == 200) {
      print("1 " + response.body);
      return EventosList.fromJson(json.decode(response.body));
    } else {
      print("2 " + response.statusCode.toString());
      return response.statusCode.toString();
    }
  }).catchError((error) {
    print('errors : $error');
    return error.toString();
  });
  throw "Erro1";
}
