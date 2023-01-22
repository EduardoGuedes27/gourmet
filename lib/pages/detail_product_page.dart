// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

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
          QuantidaItemCarrinho(),
        ],
      ),
    );
  }
}

class QuantidaItemCarrinho extends StatefulWidget {
  const QuantidaItemCarrinho({Key key}) : super(key: key);

  @override
  State<QuantidaItemCarrinho> createState() => _QuantidaItemCarrinhoState();
}

class _QuantidaItemCarrinhoState extends State<QuantidaItemCarrinho> {
  int numeroItem = 1;

  @override
  Widget build(BuildContext context) {
    final infoProdutoItem =
        ModalRoute.of(context).settings.arguments as infoProduto;
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
              height: 42,
              child: OutlinedButton(
                child: Icon(Icons.remove, color: Colors.black),
                onPressed: () {
                  setState(() {
                    if (numeroItem == 0) {
                      print('Quantidade não pode ser menor que Zero');
                    } else {
                      numeroItem--;
                    }
                  });
                },
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin / 4)),
          Text(
            '${numeroItem.toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
              height: 42,
              child: OutlinedButton(
                child: Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  setState(() {
                    numeroItem++;
                  });
                },
              ),
            ),
          ),
          Text(
            'R\$${infoProdutoItem.tpiPraticado * numeroItem}',
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 42,
              child: ElevatedButton(
                child: Text('ADICIONAR'),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
