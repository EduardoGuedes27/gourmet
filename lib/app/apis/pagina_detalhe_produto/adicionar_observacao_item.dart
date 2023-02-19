import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:gourmet_mesa/app/core/dados_globais.dart';

void addObservacao(int codigo_item, String descricao_observacao) async {
  var baseUrl = Uri.parse('${ParametrosApi.apiUrl}inserir-observacao');
  var dados = {
    "CODIGO_ITEM_COMANDA": codigo_item,
    "OBSERVACAO_ITEM_DESCRICAO": descricao_observacao
  };

  var bodyJson = json.encode(dados);

  Response response = await http.post(
    baseUrl,
    body: bodyJson,
    headers: {"Content-type": "application/json"},
  );
  var retornoDados = jsonDecode(response.body);
}
