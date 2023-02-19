// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/apis/pagina_carrinho/confirmar_compra_carrinho.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:provider/provider.dart';

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
