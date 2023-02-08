// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/apis/get/item_consumido_api.dart';
import 'package:gourmet_mesa/app/apis/post/finalizar_comanda.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/item_consumido_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class FinalizarCompraPagina extends StatefulWidget {
  const FinalizarCompraPagina({Key key}) : super(key: key);

  @override
  State<FinalizarCompraPagina> createState() => _FinalizarCompraPaginaState();
}

class _FinalizarCompraPaginaState extends State<FinalizarCompraPagina> {
  var itemsConsumidos = <ItemConsumidoModel>[];

  _getItemConsumido() {
    ItemConsumidoApi.getItemConsumido().then(
      (response) {
        setState(() {
          Iterable lista = json.decode(response.body);
          itemsConsumidos = lista
              .map(
                (model) => ItemConsumidoModel.fromJson(model),
              )
              .toList();
        });
      },
    );
  }

  _FinalizarCompraPaginaState() {
    _getItemConsumido();
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: SelectableText(
              'Checkout',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemsConsumidos.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(itemsConsumidos[index].proDescricao),
                          subtitle: Text(
                            'Total: R\$ ${(itemsConsumidos[index].citValorTot).toStringAsFixed(2)}',
                          ),
                          trailing:
                              Text('${itemsConsumidos[index].citQtdItens}X'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
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
