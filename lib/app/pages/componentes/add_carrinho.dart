// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/apis/post/adicionar_item_carrinho.dart';
import 'package:gourmet_mesa/app/apis/post/adicionar_observacao_item.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/badge_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/observacao_produto_componente.dart';
import 'package:gourmet_mesa/app/pages/inicial_pagina.dart';
import 'package:gourmet_mesa/app/provider/produto_provider.dart';
import 'package:gourmet_mesa/app/utils/rotas_pages.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class QuantidaItemCarrinho extends StatefulWidget {
  const QuantidaItemCarrinho({Key key}) : super(key: key);

  @override
  State<QuantidaItemCarrinho> createState() => _QuantidaItemCarrinhoState();
}

class _QuantidaItemCarrinhoState extends State<QuantidaItemCarrinho> {
  @override
  Widget build(BuildContext context) {
    final DadosProdutoSelecionado =
        ModalRoute.of(context).settings.arguments as infoProduto;

    final carrinhoProvider = Provider.of<CarrinhoModel>(context);

    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (ParametrosRecebidosApi.quantidade_item <= 0) {
                        print('VALOR JA ESTA ZERADO');
                      } else {
                        ParametrosRecebidosApi.quantidade_item--;
                      }
                    });
                  },
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 40, color: PaletaCores.corTexto),
                  ),
                ),
                Text(
                  '${ParametrosRecebidosApi.quantidade_item.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      ParametrosRecebidosApi.quantidade_item++;
                    });
                  },
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 35, color: PaletaCores.corTexto),
                  ),
                ),
              ],
            ),
            Text(
              'R\$${(DadosProdutoSelecionado.tpiPraticado * ParametrosRecebidosApi.quantidade_item).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                child: Text('ADICIONAR'),
                onPressed: () async {
                  DataHoraAtual();
                  if (observacaoSeleciondas.length >=
                      DadosProdutoSelecionado.proQtdObsObrigatorias) {
                    carrinhoProvider.addItem(
                      ProdutosCategoriaModel(
                        catCodigo: DadosProdutoSelecionado.catCodigo,
                        proCodigo: DadosProdutoSelecionado.proCodigo,
                        proDescricao: DadosProdutoSelecionado.proDescricao,
                        tpiPraticado: DadosProdutoSelecionado.tpiPraticado,
                        ucvCodigo: DadosProdutoSelecionado.ucvCodigo,
                      ),
                    );

                    await addItemCarrinho(
                      DadosProdutoSelecionado.proCodigo,
                      ParametrosRecebidosApi.quantidade_item,
                      DadosProdutoSelecionado.tpiPraticado,
                      DadosProdutoSelecionado.ucvCodigo,
                    );

                    if (observacaoSeleciondas.length > 0) {
                      observacaoSeleciondas.forEach((observacao) {
                        var codigo = ParametrosRecebidosApi.comanda_item_codigo;
                        addObservacao(codigo, observacao.toString());
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.greenAccent,
                        content: Text('ITEM INSERIDO COM SUCESSO'),
                      ),
                    );

                    observacaoSeleciondas = [];
                    ParametrosRecebidosApi.quantidade_item = 0;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                            'FAVOR SELECIONAR NO MINIMO ${DadosProdutoSelecionado.proQtdObsObrigatorias} OPÇÕES'),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
