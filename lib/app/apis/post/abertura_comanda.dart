// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, missing_return, prefer_const_constructors

import 'dart:convert';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void AbrirComanda() async {
  DataHoraAtual();
  var baseUrl = Uri.parse('${ParametrosApi.apiUrl}/abrir-comanda');
  var dados = {
    "NUMERO_COMANDA": inputAbrirMesa.numero_comanda,
    "NOME_CLIENTE": inputAbrirMesa.nome_cliente,
    "LOCAL_MESA": inputAbrirMesa.local_mesa,
    "DATA_ABERTURA": inputAbrirMesa.data_abertura,
  };

  var bodyJson = json.encode(dados);

  Response response = await http.post(
    baseUrl,
    body: bodyJson,
    headers: {"Content-type": "application/json"},
  );
  var retornoDados = json.decode(response.body);
  int retorno_codigo = retornoDados["CON_CODIGO"];

  ParametrosRecebidosApi.comanda_codigo = retorno_codigo;

  print(retorno_codigo);
}
