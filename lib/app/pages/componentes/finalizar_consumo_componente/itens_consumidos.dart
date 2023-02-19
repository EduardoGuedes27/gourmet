// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/apis/pagina_finalizar_consumo/item_consumido_api.dart';
import 'package:gourmet_mesa/app/model/item_consumido_model.dart';

class ItensConsumidosComponente extends StatefulWidget {
  const ItensConsumidosComponente({Key key}) : super(key: key);

  @override
  State<ItensConsumidosComponente> createState() =>
      _ItensConsumidosComponenteState();
}

class _ItensConsumidosComponenteState extends State<ItensConsumidosComponente> {
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

  _ItensConsumidosComponenteState() {
    _getItemConsumido();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    trailing: Text('${itemsConsumidos[index].citQtdItens}X'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
