import 'dart:convert';

import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/observacao_produto_model.dart';
import 'package:http/http.dart' as http;

class ObservacaoProdutoApi {
  static Future getObservacaoProduto() async {
    var url = Uri.parse(
        "${dadosApi.apiUrl}listar-observacao/${parametrosApi.codigoProduto}");
    return await http.get(url);
  }
}
