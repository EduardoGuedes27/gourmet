import 'dart:convert';

import 'package:gourmet_mesa/model/categorias_model.dart';
import 'package:http/http.dart' as http;

class CategoriaApi {
  Future<List<Categoria>> getCategorias() async {
    final response = await http.get('http://localhost:9000/categorias');

    if (response.statusCode == 200) {
      final decode = json.decode(response.body);
      var listaCaregoria = new List<Categoria>();

      for (var categoria in decode) {
        var categoriaItem = new Categoria.fromJson(categoria);
        listaCaregoria.add(categoriaItem);
      }
      return listaCaregoria;
    }

    return [];
  }
}
