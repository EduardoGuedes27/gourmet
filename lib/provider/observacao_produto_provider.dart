import 'package:flutter/cupertino.dart';
import 'package:gourmet_mesa/apis/observacao_produto_api.dart';
import 'package:gourmet_mesa/model/observacao_produto_model.dart';

class ObservacaoProdutoProvider extends ChangeNotifier {
  List<ObservacaoProduto> observacoes;

  Future<List<ObservacaoProduto>> getObservacoesProduto() async {
    if (observacoes != null) {
      return observacoes;
    }
    var api = new ObservacaoProdutoApi();
    this.observacoes = await api.getObservacaoProduto();
    notifyListeners();
    return observacoes;
  }

  Future<List<ObservacaoProduto>> refreshObservacaoProduto() async {
    var api = new ObservacaoProdutoApi();
    this.observacoes = await api.getObservacaoProduto();
    notifyListeners();
    return observacoes;
  }
}
