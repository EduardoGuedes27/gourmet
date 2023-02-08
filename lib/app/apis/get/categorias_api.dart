import 'dart:convert';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/model/categorias_model.dart';
import 'package:http/http.dart' as http;

class CategoriasApi {
  Future<List<CategoriasModel>> getCategorias() async {
    var conversao_url = Uri.parse("${ParametrosApi.apiUrl}categorias");

    final response = await http.get(conversao_url);

    if (response.statusCode == 200) {
      final decode = json.decode(response.body);
      var listaCaregoria = new List<CategoriasModel>();

      for (var categoria in decode) {
        var categoriaItem = new CategoriasModel.fromJson(categoria);
        listaCaregoria.add(categoriaItem);
      }
      return listaCaregoria;
    }

    return [];
  }
}
