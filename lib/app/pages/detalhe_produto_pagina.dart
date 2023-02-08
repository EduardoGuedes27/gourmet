// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/barra_adicionar_item_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/badge_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/observacao_produto_componente.dart';
import 'package:gourmet_mesa/app/pages/inicial_pagina.dart';
import 'package:gourmet_mesa/app/provider/produto_provider.dart';
import 'package:gourmet_mesa/app/utils/rotas_pages.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class DetalheProdutoPagina extends StatefulWidget {
  const DetalheProdutoPagina({Key key}) : super(key: key);

  @override
  State<DetalheProdutoPagina> createState() => _DetalheProdutoPaginaState();
}

class _DetalheProdutoPaginaState extends State<DetalheProdutoPagina> {
  @override
  Widget build(BuildContext context) {
    final DadosProdutosSelecionados =
        ModalRoute.of(context).settings.arguments as infoProduto;
    final carrrinhoProvider = Provider.of<CarrinhoModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: PaletaCores.corTexto),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          BadgeComponente(
            value: carrrinhoProvider.quantidadeItem.toString(),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: PaletaCores.corTexto),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART_PAGE);
              },
            ),
          ),
          SizedBox(
            width: kDefaultPaddin / 2,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
            child: Center(
              child: SelectableText(
                '${DadosProdutosSelecionados.proDescricao}',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
            child: Center(
              child: SelectableText('${DadosProdutosSelecionados.proObs}',
                  style: TextStyle(color: PaletaCores.corTexto, fontSize: 18)),
            ),
          ),
          observaoProdutoComponente(),
          Divider(),
          BarraAdicionarItemComponente(),
        ],
      ),
    );
  }
}
