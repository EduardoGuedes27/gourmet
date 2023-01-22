// ignore_for_file: missing_return, missing_required_param, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/apis/observacao_produto_api.dart';
import 'package:gourmet_mesa/model/observacao_produto_model.dart';
import 'package:gourmet_mesa/model/produtos_categoria_model.dart';
import 'package:provider/provider.dart';

class observaoProdutoComponente extends StatefulWidget {
  const observaoProdutoComponente({Key key}) : super(key: key);

  @override
  State<observaoProdutoComponente> createState() =>
      _observaoProdutoComponenteState();
}

class _observaoProdutoComponenteState extends State<observaoProdutoComponente> {
  var obsersavaoProduto = <ObservacaoProduto>[];

  _getObservacaoProduto() {
    API.getObservacaoProduto().then(
      (respose) {
        setState(
          () {
            Iterable lista = json.decode(respose.body);
            obsersavaoProduto = lista
                .map((model) => ObservacaoProduto.fromJson(model))
                .toList();
          },
        );
      },
    );
  }

  _observaoProdutoComponenteState() {
    _getObservacaoProduto();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: obsersavaoProduto.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(obsersavaoProduto[index].pobDescricao),
            key: Key(obsersavaoProduto[index].pobCodigo.toString()),
            value: obsersavaoProduto[index].check,
            onChanged: (value) {
              setState(() {
                obsersavaoProduto[index].check = true;
              });
            },
          );
        },
      ),
    );
  }
}
