// ignore_for_file: missing_return, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/categorias_model.dart';
import 'package:gourmet_mesa/provider/categoria_provider.dart';
import 'package:gourmet_mesa/provider/produto_provider.dart';
import 'package:provider/provider.dart';

class CategoriasComponente extends StatefulWidget {
  const CategoriasComponente({Key key}) : super(key: key);

  @override
  State<CategoriasComponente> createState() => _CategoriasComponenteState();
}

class _CategoriasComponenteState extends State<CategoriasComponente> {
  int IndexCategoriaSelecionada = 0;
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

  Widget _ItemCategoria(Categoria categoria) {
    final categoriasProvider = Provider.of<ProdutoProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          parametrosApi.codigoCategoria = categoria.catcodigo;
          categoriasProvider.refreshProdutos();
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
      builder: (context, AsyncSnapshot<List<Categoria>> snapshot) {
        if (snapshot.hasData) {
          final dadosCategorias = snapshot.data;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: dadosCategorias.length,
            itemBuilder: (context, int i) {
              return _ItemCategoria(dadosCategorias[i]);
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
