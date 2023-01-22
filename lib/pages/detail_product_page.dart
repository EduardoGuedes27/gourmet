// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/pages/componentes/observacao_produto_componente.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({Key key}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    final infoProdutoItem =
        ModalRoute.of(context).settings.arguments as infoProduto;

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: kTextColor),
            onPressed: () {},
          ),
          SizedBox(
            width: kDefaultPaddin / 2,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
            child: Center(
              child: SelectableText(
                '${infoProdutoItem.proDescricao}',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
            child: Center(
              child: SelectableText('${infoProdutoItem.proObs}',
                  style: TextStyle(color: kTextColor, fontSize: 18)),
            ),
          ),
          observaoProdutoComponente(),
        ],
      ),
    );
  }
}
