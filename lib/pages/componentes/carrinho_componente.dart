// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/carrinho.dart';
import 'package:gourmet_mesa/model/carrinho_item.dart';
import 'package:gourmet_mesa/pages/detail_product_page.dart';
import 'package:gourmet_mesa/pages/home_page.dart';
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
    final carrinhoProvider = Provider.of<Carrinho>(context);

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
                _ConfirmarCompraItem();
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

class produtosCarrinhoComponente extends StatefulWidget {
  const produtosCarrinhoComponente({Key key}) : super(key: key);

  @override
  State<produtosCarrinhoComponente> createState() =>
      _produtosCarrinhoComponenteState();
}

class _produtosCarrinhoComponenteState
    extends State<produtosCarrinhoComponente> {
  @override
  Widget build(BuildContext context) {
    final carrinhoProvider = Provider.of<Carrinho>(context);
    final items = carrinhoProvider.items.values.toList();

    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (_) {
              void _DeletarItemCarrinho() async {
                var url = Uri.parse(
                    "${dadosApi.apiUrl}remover-item/${codigoComanda}/${items[index].codigoProduto}");
                var response = await http.delete(url);
                if (response.statusCode == 200) {
                  print('object');
                  carrinhoProvider.removerItem(items[index].codigoProduto);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text('Item Removido com Sucesso'),
                    ),
                  );
                }
              }

              _DeletarItemCarrinho();
            },
            key: ValueKey(items[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).errorColor,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 3,
              ),
            ),
            child: Card(
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
                      leading: CircleAvatar(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                                '${items[index].precoProduto.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(items[index].nomeProduto),
                      subtitle: Text(
                        'Total: R\$ ${(items[index].precoProduto * items[index].quantidadeProduto).toStringAsFixed(2)}',
                      ),
                      trailing: Text('${items[index].quantidadeProduto}X'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _ConfirmarCompraItem() async {
  var baseUrl = Uri.parse('${dadosApi.apiUrl}/confirma-compra-item');
  var dados = {
    "COMANDA_CODIGO": codigoComanda,
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
