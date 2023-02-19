// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/apis/pagina_finalizar_consumo/finalizar_comanda.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/pages/componentes/finalizar_consumo_componente/itens_consumidos.dart';
import 'package:gourmet_mesa/app/pages/componentes/styles_componentes/titulo_page_componente.dart';

class FinalizarCompraPagina extends StatefulWidget {
  const FinalizarCompraPagina({Key key}) : super(key: key);

  @override
  State<FinalizarCompraPagina> createState() => _FinalizarCompraPaginaState();
}

class _FinalizarCompraPaginaState extends State<FinalizarCompraPagina> {
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
      ),
      body: Column(
        children: <Widget>[
          TituloPaginaComponente(titulo_pagina: 'Finalizar Consumo'),
          ItensConsumidosComponente(),
          Center(
            child: ElevatedButton(
              child: Text('Pedir Conta'),
              onPressed: () {
                FinalizarComanda();
              },
            ),
          ),
        ],
      ),
    );
  }
}
