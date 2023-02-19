import 'dart:convert';

import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void FinalizarComanda() async {
  var baseUrl = Uri.parse('${ParametrosApi.apiUrl}/encerrar-comanda');
  var dados = {
    "CONTA_CODIGO": ParametrosRecebidosApi.comanda_codigo,
  };

  var bodyJson = json.encode(dados);

  Response response = await http.patch(
    baseUrl,
    body: bodyJson,
    headers: {"Content-type": "application/json"},
  );
  var retornoDados = json.decode(response.body);
}
