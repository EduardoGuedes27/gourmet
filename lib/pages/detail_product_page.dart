// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/model/carrinho.dart';
import 'package:gourmet_mesa/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/pages/componentes/badge.dart';
import 'package:gourmet_mesa/pages/componentes/observacao_produto_componente.dart';
import 'package:gourmet_mesa/pages/home_page.dart';
import 'package:gourmet_mesa/provider/produto_provider.dart';
import 'package:gourmet_mesa/utils/rotas_pages.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

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
    final carrrinhoProvider = Provider.of<Carrinho>(context);

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
          BadgeComponente(
            value: carrrinhoProvider.quantidadeItem.toString(),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: kTextColor),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART_PAGE);
              },
            ),
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

int numeroItem = 1;
var comanda_item_codigo;

class _QuantidaItemCarrinhoState extends State<QuantidaItemCarrinho> {
  @override
  Widget build(BuildContext context) {
    final infoProdutoItem =
        ModalRoute.of(context).settings.arguments as infoProduto;

    final carrinhoProvider = Provider.of<Carrinho>(context);

    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (numeroItem <= 0) {
                        print('VALOR JA ESTA ZERADO');
                      } else {
                        numeroItem--;
                      }
                    });
                  },
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 40, color: kTextColor),
                  ),
                ),
                Text(
                  '${numeroItem.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      numeroItem++;
                    });
                  },
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 35, color: kTextColor),
                  ),
                ),
              ],
            ),
            Text(
              'R\$${(infoProdutoItem.tpiPraticado * numeroItem).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                child: Text('ADICIONAR'),
                onPressed: () {
                  carrinhoProvider.addItem(
                    Produto(
                      catCodigo: infoProdutoItem.catCodigo,
                      proCodigo: infoProdutoItem.proCodigo,
                      proDescricao: infoProdutoItem.proDescricao,
                      tpiPraticado: infoProdutoItem.tpiPraticado,
                      ucvCodigo: infoProdutoItem.ucvCodigo,
                    ),
                  );

                  DataHoraAtual();

                  void _addItemCarrinho() async {
                    var baseUrl = Uri.parse('${dadosApi.apiUrl}/inserir-item');
                    var dados = {
                      "COMANDA_CODIGO": codigoComanda,
                      "PRO_CODIGO": infoProdutoItem.proCodigo,
                      "COMANDA_ITEM_QTD": numeroItem,
                      "COMANDA_ITEM_VALOR_UNT": infoProdutoItem.tpiPraticado,
                      "UCV_CODIGO": infoProdutoItem.ucvCodigo,
                      "COMANDA_ITEM_DATA_INSERCAO": _dataHoraAtual,
                    };

                    var bodyJson = json.encode(dados);

                    Response response = await http.post(
                      baseUrl,
                      body: bodyJson,
                      headers: {"Content-type": "application/json"},
                    );
                    var retornoDados = jsonDecode(response.body);
                  }

                  _addItemCarrinho();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

var _dataHoraAtual = '';
//ESTA FUNÇÃO PEGA A DATA ATUAL NO FORMATO 'YYYY/MM/DD HH:MM:SS'
void DataHoraAtual() {
  var dia = DateTime.now().day.toString().padLeft(2, '0');
  var mes = DateTime.now().month.toString().padLeft(2, '0');
  var ano = DateTime.now().year.toString().padLeft(4, '0');
  var hora = DateTime.now().hour.toString().padLeft(2, '0');
  var minuto = DateTime.now().minute.toString().padLeft(2, '0');
  var segundo = DateTime.now().second.toString().padLeft(2, '0');
  _dataHoraAtual = '${ano}/${mes}/${dia} ${hora}:${minuto}:${segundo}';
}
