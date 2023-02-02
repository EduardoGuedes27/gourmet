// COMPONENTE PARA MOSTRA QUE A PRODUTOS NO CARRINHO
// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:provider/provider.dart';

class BadgeComponente extends StatelessWidget {
  final Widget child;
  final String value;
  final Color color;
  const BadgeComponente({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carrinhoProvider = Provider.of<CarrinhoModel>(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: carrinhoProvider.quantidadeItem != 0
                    ? Colors.red[300]
                    : Colors.transparent,
              ),
              constraints: BoxConstraints(
                minHeight: 16,
                minWidth: 16,
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: carrinhoProvider.quantidadeItem != 0
                      ? Colors.black
                      : Colors.transparent,
                ),
              )),
        )
      ],
    );
  }
}
