// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/provider/produto_provider.dart';
import 'package:gourmet_mesa/utils/rotas_pages.dart';
import 'package:provider/provider.dart';

class ProdutosComponente extends StatefulWidget {
  const ProdutosComponente({Key key}) : super(key: key);

  @override
  State<ProdutosComponente> createState() => _ProdutosComponenteState();
}

class _ProdutosComponenteState extends State<ProdutosComponente> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: _listaProdutos(),
      ),
    );
  }

  Widget _Produto(Produto produto) {
    return GestureDetector(
      onTap: () {
        parametrosApi.codigoProduto = produto.proCodigo;
        Navigator.of(context).pushNamed(
          AppRoutes.DETALHE_PRODUTO,
          arguments: infoProduto(
            produto.catCodigo,
            produto.proCodigo,
            produto.proDescricao,
            produto.tpiPraticado,
            produto.ucvCodigo,
            produto.proQtdObsObrigatorias,
            produto.proObs,
            produto.caminhoImgUrl,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(produto.caminhoImgUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              produto.proDescricao,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              'R\$ ${produto.tpiPraticado.toStringAsFixed(2)}',
              style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listaProdutos() {
    final produtosProvider = Provider.of<ProdutoProvider>(context);

    return FutureBuilder(
      future: produtosProvider.getProdutos(),
      builder: (_, AsyncSnapshot<List<Produto>> snapshot) {
        if (snapshot.hasData) {
          final dadosProdutos = snapshot.data;
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPaddin,
              crossAxisSpacing: kDefaultPaddin,
              childAspectRatio: 0.75,
            ),
            itemCount: dadosProdutos.length,
            itemBuilder: (context, index) {
              return _Produto(dadosProdutos[index]);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
