// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/detalhe_produto_componente/barra_adicionar_item_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/homepage_componente/badge_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/detalhe_produto_componente/observacao_produto_componente.dart';
import 'package:gourmet_mesa/app/utils/rotas_pages.dart';
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
