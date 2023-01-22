import 'dart:convert';

import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/observacao_produto_model.dart';
import 'package:http/http.dart' as http;

class ObservacaoProdutoApi {
  Future<List<ObservacaoProduto>> getObservacaoProduto() async {
    final response = await http.get(
        '${dadosApi.apiUrl}listar-observacao/${parametrosApi.codigoProduto}');

    if (response.statusCode == 200) {
      final decode = json.decode(response.body);

      var listaObservacao = new List<ObservacaoProduto>();

      for (var observacao in decode) {
        var observacaoItem = new ObservacaoProduto.fromJson(observacao);
        listaObservacao.add(observacaoItem);
      }
      return listaObservacao;
    }
    return [];
  }
}
