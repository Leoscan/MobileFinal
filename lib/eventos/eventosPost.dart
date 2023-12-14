import 'package:flutter/material.dart';
import 'package:apirequest/eventos/eventosList.dart';
import 'package:apirequest/eventos/eventos.dart';
import 'package:apirequest/conexao/EndPoints.dart';

class EventosPost extends StatefulWidget {
  @override
  _EventosPost createState() => _EventosPost();
}

class _EventosPost extends State {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Eventos evento = new Eventos();
  Future<EventosList>? eventoListFuture;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: this._formKey,
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (String? inValue) {
                  this.evento.id = int.parse(inValue!);
                },
                decoration: InputDecoration(labelText: "Id")),
            TextFormField(
                keyboardType: TextInputType.text,
                validator: (String? inValue) {
                  if (inValue!.length == 0) {
                    return "Por favor entre com o modelo";
                  }
                  return null;
                },
                onSaved: (String? inValue) {
                  this.evento.model = inValue!;
                },
                decoration: InputDecoration(labelText: "titulo")),
            TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (String? inValue) {
                  this.evento.data = DateTime.parse(inValue!);
                },
                decoration: InputDecoration(labelText: "data")),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print("Id: ${evento.id}");
                  print("titulo: ${evento.model}");
                  print("data: ${evento.data}");
                  callAPI(evento);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
