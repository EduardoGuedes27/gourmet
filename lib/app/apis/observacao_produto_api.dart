import 'dart:convert';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/model/observacao_produto_model.dart';
import 'package:http/http.dart' as http;

class ObservacaoProdutoApi {
  static Future getObservacaoProduto() async {
    var url = Uri.parse(
        "${ParametrosApi.apiUrl}listar-observacao/${ParametrosApi.codigoProduto}");
    return await http.get(url);
  }
}
