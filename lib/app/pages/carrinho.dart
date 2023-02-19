// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/pages/componentes/carrinho_componente/carrinho_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/carrinho_componente/item_carrinho_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/styles_componentes/titulo_page_componente.dart';

class CarrinhoPagina extends StatefulWidget {
  const CarrinhoPagina({Key key}) : super(key: key);

  @override
  State<CarrinhoPagina> createState() => _CarrinhoPaginaState();
}

class _CarrinhoPaginaState extends State<CarrinhoPagina> {
  @override
  Widget build(BuildContext context) {
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
          IconButton(
            icon: Icon(Icons.search, color: PaletaCores.corTexto),
            onPressed: () {},
          ),
          SizedBox(
            width: kDefaultPaddin / 2,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          TituloPaginaComponente(titulo_pagina: 'Carrinho'),
          CardCarrinhoComponente(),
          produtosCarrinhoComponente(),
        ],
      ),
    );
  }
}
