import 'package:flutter/cupertino.dart';
import 'package:gourmet_mesa/app/apis/pagina_home/categorias_api.dart';
import 'package:gourmet_mesa/app/model/categorias_model.dart';

class CategoriaProvider extends ChangeNotifier {
  List<CategoriasModel> categorias;

  Future<List<CategoriasModel>> getCategorias() async {
    if (categorias != null) {
      return categorias;
    }
    var api = CategoriasApi();
    categorias = await api.getCategorias();
    notifyListeners();

    return categorias;
  }

  Future<List<CategoriasModel>> refreshCategorias() async {
    var api = CategoriasApi();
    categorias = await api.getCategorias();
    notifyListeners();

    return categorias;
  }
}
