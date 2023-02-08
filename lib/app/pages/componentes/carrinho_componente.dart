// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/apis/post/confirmar_compra_carrinho.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/model/carrinho_item_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/item_carrinho_componente.dart';
import 'package:gourmet_mesa/app/pages/detalhe_produto_pagina.dart';
import 'package:gourmet_mesa/app/pages/inicial_pagina.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CardCarrinhoComponente extends StatefulWidget {
  const CardCarrinhoComponente({Key key}) : super(key: key);

  @override
  State<CardCarrinhoComponente> createState() => _CardCarrinhoComponenteState();
}

class _CardCarrinhoComponenteState extends State<CardCarrinhoComponente> {
  @override
  Widget build(BuildContext context) {
    final carrinhoProvider = Provider.of<CarrinhoModel>(context);

    final items = carrinhoProvider.items.values;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 15,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Chip(
              backgroundColor: Theme.of(context).primaryColor,
              label: Text(
                'R\$ ${carrinhoProvider.totalCarrinho.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.headline6.color),
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                ConfirmarCompraItem();
                carrinhoProvider.limparCarrinho();
              },
              child: Text('Comprar'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ) 
          ],
        ),
      ),
    );
  }
}
