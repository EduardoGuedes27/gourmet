// ignore_for_file: unused_local_variable, prefer_collection_literals, unnecessary_new, deprecated_member_use
import 'dart:convert';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:http/http.dart' as http;

class ProdutosApi {
  Future<List<ProdutosCategoriaModel>> getProdrutos() async {
    var conversao_url = Uri.parse(
        '${ParametrosApi.apiUrl}produto-categoria/${ParametrosApi.codigoCategoria}');
    final response = await http.get(conversao_url);

    if (response.statusCode == 200) {
      final decode = await json.decode(response.body);

      var listaprodutos = new List<ProdutosCategoriaModel>();

      for (var produto in decode) {
        var produtoItem = new ProdutosCategoriaModel.fromJson(produto);
        listaprodutos.add(produtoItem);
      }

      return listaprodutos;
    }

    return [];
  }
}
