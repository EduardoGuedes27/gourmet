// ignore_for_file: unused_local_variable, prefer_collection_literals, unnecessary_new, deprecated_member_use

import 'dart:convert';

import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/produtos_categoria_model.dart';
import 'package:http/http.dart' as http;

class ProdutosApi {
  Future<List<Produto>> getProdrutos() async {
    var conversao_url = Uri.parse(
        '${dadosApi.apiUrl}produto-categoria/${parametrosApi.codigoCategoria}');
    final response = await http.get(conversao_url);

    if (response.statusCode == 200) {
      final decode = await json.decode(response.body);

      var listaprodutos = new List<Produto>();

      for (var produto in decode) {
        var produtoItem = new Produto.fromJson(produto);
        listaprodutos.add(produtoItem);
      }

      return listaprodutos;
    }

    return [];
  }
}
