import 'package:flutter/foundation.dart';
import 'package:gourmet_mesa/app/apis/pagina_home/produtos_api.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';

class ProdutoProvider extends ChangeNotifier {
  List<ProdutosCategoriaModel> produtos;

  Future<List<ProdutosCategoriaModel>> getProdutos() async {
    if (produtos != null) {
      return produtos;
    }
    var api = ProdutosApi();
    produtos = await api.getProdrutos();
    notifyListeners();

    return produtos;
  }

  Future<List<ProdutosCategoriaModel>> refreshProdutos() async {
    var api = ProdutosApi();
    produtos = await api.getProdrutos();
    notifyListeners();

    return produtos;
  }
}
