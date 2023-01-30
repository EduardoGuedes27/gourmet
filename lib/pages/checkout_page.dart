// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/apis/item_consumido.dart';
import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/item_consumido_model.dart';
import 'package:gourmet_mesa/pages/home_page.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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

  _CheckoutPageState() {
    _getItemConsumido();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: kTextColor),
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
                // _PedirConta();
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _PedirConta() async {
  var baseUrl = Uri.parse('${dadosApi.apiUrl}/encerrar-comanda');
  var dados = {
    "CONTA_CODIGO": codigoComanda,
  };

  var bodyJson = json.encode(dados);

  Response response = await http.patch(
    baseUrl,
    body: bodyJson,
    headers: {"Content-type": "application/json"},
  );
  var retornoDados = json.decode(response.body);
  print(retornoDados);
}
