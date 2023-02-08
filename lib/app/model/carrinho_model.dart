import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/model/carrinho_item_model.dart';
import 'package:gourmet_mesa/app/model/observacao_produto_model.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/add_carrinho.dart';
import 'package:gourmet_mesa/app/pages/detalhe_produto_pagina.dart';

class CarrinhoModel with ChangeNotifier {
  Map<String, CarrinhoItemModel> _items = {};

  Map<String, CarrinhoItemModel> get items {
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

  void addItem(ProdutosCategoriaModel produto) {
    if (_items.containsKey(produto.proCodigo.toString())) {
      _items.update(
        produto.proCodigo.toString(),
        (produtoExistemte) => CarrinhoItemModel(
          id: produtoExistemte.id,
          codigoProduto: produtoExistemte.codigoProduto,
          nomeProduto: produtoExistemte.nomeProduto,
          quantidadeProduto: produtoExistemte.quantidadeProduto +
              ParametrosRecebidosApi.quantidade_item,
          precoProduto: produtoExistemte.precoProduto,
        ),
      );
    } else {
      _items.putIfAbsent(
        produto.proCodigo.toString(),
        () => CarrinhoItemModel(
          id: Random().nextInt(100).toString(),
          codigoProduto: produto.proCodigo.toString(),
          nomeProduto: produto.proDescricao,
          quantidadeProduto: ParametrosRecebidosApi.quantidade_item,
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
