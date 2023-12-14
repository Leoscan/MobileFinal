import 'package:flutter/material.dart';
import 'package:apirequest/eventos/eventosList.dart';
import 'package:apirequest/eventos/eventos.dart';
import 'package:apirequest/conexao/EndPoints.dart';

class EventoUI extends StatefulWidget {
  @override
  _EventoUI createState() => _EventoUI();
}

class _EventoUI extends State {
  Future<EventosList>? evListFuture;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<EventosList>(
          future: evListFuture,
          builder: (context, snapshot) {
            // Com switch conseguimos identificar em que ponto da conexão estamos
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return loadingView();
                }
              case ConnectionState.active:
                {
                  break;
                }
              case ConnectionState.done:
                {
                  // Se o estado é de finalizado, será trabalhado os dados do snapshot recebido
                  // snapshot representa um instantâneo (foto) dos dados recebidos
                  // Se o snapshot tem informações, apresenta
                  if (snapshot.hasData) {
                    if (snapshot.data!.evList != null) {
                      if (snapshot.data!.evList!.length > 0) {
                        // preenche a lista
                        return ListView.builder(
                            itemCount: snapshot.data!.evList!.length,
                            itemBuilder: (context, index) {
                              return generateColum(
                                  snapshot.data!.evList![index]);
                            });
                      } else {
                        // Em caso de retorno de lista vazia
                        return noDataView("1 No data found");
                      }
                    } else {
                      // Apresenta erro se a lista ou os dados são nulos
                      return noDataView("2 No data found");
                    }
                  } else if (snapshot.hasError) {
                    // Apresenta mensagem se teve algum erro
                    print(snapshot.error);
                    return noDataView("1 car Something went wrong: " +
                        snapshot.error.toString());
                  } else {
                    return noDataView("2 Something went wrong");
                  }
                }
              case ConnectionState.none:
                {
                  break;
                }
            }
            throw "Error";
          }),
    );
  }

  @override
  void initState() {
    // Verificamos a conexão com a internet
    isConnected().then((internet) {
      if (internet) {
        // define o estado enquanto carrega as informações da API
        setState(() {
          // chama a API para apresentar os dados
          // Aqui estamos no initState (ao iniciar a aplicação/tela), mas pode ser iniciado com um click de botão.
          evListFuture = geteventoListData();
        });
      }
    });
    super.initState();
  }

  Widget generateColum(Eventos item) => Card(
        child: ListTile(
          title: Text(
            item.model!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle:
              Text(item.data, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
}