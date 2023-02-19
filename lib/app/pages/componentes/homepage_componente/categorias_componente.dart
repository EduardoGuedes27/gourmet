// ignore_for_file: missing_return, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/model/categorias_model.dart';
import 'package:gourmet_mesa/app/provider/categoria_provider.dart';
import 'package:gourmet_mesa/app/provider/produto_provider.dart';
import 'package:provider/provider.dart';

class CategoriasComponente extends StatefulWidget {
  const CategoriasComponente({Key key}) : super(key: key);

  @override
  State<CategoriasComponente> createState() => _CategoriasComponenteState();
}

class _CategoriasComponenteState extends State<CategoriasComponente> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 30,
        child: _ListaCategorias(),
      ),
    );
  }

  Widget _ItemCategoria(CategoriasModel categoria) {
    final produtosProvider = Provider.of<ProdutoProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          ParametrosApi.codigoCategoria = categoria.catcodigo;
          produtosProvider.refreshProdutos();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categoria.catdescricao,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4),
              height: 2,
              width: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget _ListaCategorias() {
    final categoriasProvider = Provider.of<CategoriaProvider>(context);

    return FutureBuilder(
      future: categoriasProvider.getCategorias(),
      builder: (context, AsyncSnapshot<List<CategoriasModel>> snapshot) {
        if (snapshot.hasData) {
          final dadosCategorias = snapshot.data;
          print(dadosCategorias);
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: dadosCategorias.length,
            itemBuilder: (context, index) {
              return _ItemCategoria(dadosCategorias[index]);
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
