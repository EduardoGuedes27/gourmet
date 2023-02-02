import 'package:flutter/cupertino.dart';
import 'package:gourmet_mesa/app/apis/categorias_api.dart';
import 'package:gourmet_mesa/app/model/categorias_model.dart';

class CategoriaProvider extends ChangeNotifier {
  List<CategoriasModel> categorias;

  Future<List<CategoriasModel>> getCategorias() async {
    if (categorias != null) {
      return categorias;
    }
    var api = new CategoriasApi();
    this.categorias = await api.getCategorias();
    notifyListeners();

    return categorias;
  }

  Future<List<CategoriasModel>> refreshCategorias() async {
    var api = new CategoriasApi();
    this.categorias = await api.getCategorias();
    notifyListeners();

    return categorias;
  }
}
