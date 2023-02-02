// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/provider/categoria_provider.dart';
import 'package:gourmet_mesa/app/provider/produto_provider.dart';
import 'package:gourmet_mesa/app/utils/rotas_pages.dart';
import 'package:provider/provider.dart';

class ProdutosComponente extends StatefulWidget {
  const ProdutosComponente({Key key}) : super(key: key);

  @override
  State<ProdutosComponente> createState() => _ProdutosComponenteState();
}

class _ProdutosComponenteState extends State<ProdutosComponente> {
  @override
  Widget build(BuildContext context) {
    final categoriaProvider = Provider.of<CategoriaProvider>(context);
    final infoProdutoItem =
        ModalRoute.of(context).settings.arguments as infoProduto;
    if (categoriaProvider.categorias != null) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: _listaProdutos(),
        ),
      );
    } else {
      return Center(child: Text('NÃO FOI POSSIVEL CARREGAR AS CATEGORIAS'));
    }
  }

  Widget _Produto(ProdutosCategoriaModel produto) {
    return GestureDetector(
      onTap: () {
        ParametrosApi.codigoProduto = produto.proCodigo;
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
              style: TextStyle(color: PaletaCores.corTextoLeve),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              'R\$ ${(produto.tpiPraticado).toStringAsFixed(2)}',
              style: TextStyle(
                  color: PaletaCores.corTexto, fontWeight: FontWeight.bold),
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
      builder: (_, AsyncSnapshot<List<ProdutosCategoriaModel>> snapshot) {
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
