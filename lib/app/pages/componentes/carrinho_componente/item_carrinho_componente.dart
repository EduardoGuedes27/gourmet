// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/pages/home_page.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
    final carrinhoProvider = Provider.of<CarrinhoModel>(context);
    final items = carrinhoProvider.items.values.toList();

    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (_) {
              void _DeletarItemCarrinho() async {
                var url = Uri.parse(
                    "${ParametrosApi.apiUrl}remover-item/${ParametrosRecebidosApi.comanda_codigo}/${items[index].codigoProduto}");
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
