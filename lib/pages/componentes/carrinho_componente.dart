// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/model/carrinho.dart';
import 'package:provider/provider.dart';

class CardCarrinhoComponente extends StatefulWidget {
  const CardCarrinhoComponente({Key key}) : super(key: key);

  @override
  State<CardCarrinhoComponente> createState() => _CardCarrinhoComponenteState();
}

class _CardCarrinhoComponenteState extends State<CardCarrinhoComponente> {
  @override
  Widget build(BuildContext context) {
    final carrinhoProvider = Provider.of<Carrinho>(context);

    return Card(
      margin: const EdgeInsets.all(25),
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
                //'R\$ ${carrinhoProvider.totalCarrinho}',
                'R\$ VERIFICAR',
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.headline6.color),
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
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
