import 'package:flutter/foundation.dart';
import 'package:gourmet_mesa/apis/produtos_api.dart';
import 'package:gourmet_mesa/model/produtos_categoria_model.dart';

class ProdutoProvider extends ChangeNotifier {
  List<Produto> produtos;

  Future<List<Produto>> getProdutos() async {
    if (produtos != null) {
      return produtos;
    }
    var api = new ProdutosApi();
    this.produtos = await api.getProdrutos();
    notifyListeners();

    return produtos;
  }

  Future<List<Produto>> refreshProdutos() async {
    var api = new ProdutosApi();
    this.produtos = await api.getProdrutos();
    notifyListeners();

    return produtos;
  }
}
