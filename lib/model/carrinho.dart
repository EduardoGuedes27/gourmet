import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:gourmet_mesa/model/carrinho_item.dart';
import 'package:gourmet_mesa/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/pages/detail_product_page.dart';

class Carrinho with ChangeNotifier {
  Map<String, CarrinhoItem> _items = {};

  Map<String, CarrinhoItem> get items {
    return {..._items};
  }

  int get quantidadeItem {
    return _items.length;
  }

  double get totalCarrinho {
    double valorTotal = 0.0;
    items.forEach(
      (key, carrinhoItem) {
        valorTotal +=
            carrinhoItem.precoProduto * carrinhoItem.quantidadeProduto;
      },
    );
    return valorTotal;
  }

  void addItem(Produto produto) {
    if (_items.containsKey(produto.proCodigo.toString())) {
      _items.update(
        produto.proCodigo.toString(),
        (produtoExistemte) => CarrinhoItem(
          id: produtoExistemte.id,
          codigoProduto: produtoExistemte.codigoProduto,
          nomeProduto: produtoExistemte.nomeProduto,
          quantidadeProduto: produtoExistemte.quantidadeProduto + numeroItem,
          precoProduto: produtoExistemte.precoProduto,
        ),
      );
    } else {
      _items.putIfAbsent(
        produto.proCodigo.toString(),
        () => CarrinhoItem(
          id: Random().nextInt(100).toString(),
          codigoProduto: produto.proCodigo.toString(),
          nomeProduto: produto.proDescricao,
          quantidadeProduto: numeroItem,
          precoProduto: produto.tpiPraticado,
        ),
      );
    }
    notifyListeners();
  }

  void removerItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void limparCarrinho() {
    _items = {};
    notifyListeners();
  }
}
