import 'package:flutter/cupertino.dart';
import 'package:gourmet_mesa/apis/categorias_api.dart';
import 'package:gourmet_mesa/model/categorias_model.dart';

class CategoriaProvider extends ChangeNotifier {
  List<Categoria> categorias;

  Future<List<Categoria>> getCategorias() async {
    if (categorias != null) {
      return categorias;
    }
    var api = new CategoriaApi();
    this.categorias = await api.getCategorias();
    notifyListeners();

    return categorias;
  }

  Future<List<Categoria>> refreshCategorias() async {
    var api = new CategoriaApi();
    this.categorias = await api.getCategorias();
    notifyListeners();

    return categorias;
  }
}
