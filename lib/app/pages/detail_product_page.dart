// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/badge.dart';
import 'package:gourmet_mesa/app/pages/componentes/observacao_produto_componente.dart';
import 'package:gourmet_mesa/app/pages/home_page.dart';
import 'package:gourmet_mesa/app/provider/produto_provider.dart';
import 'package:gourmet_mesa/app/utils/rotas_pages.dart';
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
    final carrrinhoProvider = Provider.of<CarrinhoModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: PaletaCores.corTexto),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          BadgeComponente(
            value: carrrinhoProvider.quantidadeItem.toString(),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: PaletaCores.corTexto),
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
                  style: TextStyle(color: PaletaCores.corTexto, fontSize: 18)),
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

    final carrinhoProvider = Provider.of<CarrinhoModel>(context);

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
                    style: TextStyle(fontSize: 40, color: PaletaCores.corTexto),
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
                    style: TextStyle(fontSize: 35, color: PaletaCores.corTexto),
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
                onPressed: () async {
                  if (observacaoSeleciondas.length >=
                      infoProdutoItem.proQtdObsObrigatorias) {
                    carrinhoProvider.addItem(
                      ProdutosCategoriaModel(
                        catCodigo: infoProdutoItem.catCodigo,
                        proCodigo: infoProdutoItem.proCodigo,
                        proDescricao: infoProdutoItem.proDescricao,
                        tpiPraticado: infoProdutoItem.tpiPraticado,
                        ucvCodigo: infoProdutoItem.ucvCodigo,
                      ),
                    );
                    DataHoraAtual();

                    void _addItemCarrinho() async {
                      var baseUrl =
                          Uri.parse('${ParametrosApi.apiUrl}inserir-item');
                      var dados = {
                        "COMANDA_CODIGO": codigoComanda,
                        "PRO_CODIGO": infoProdutoItem.proCodigo,
                        "COMANDA_ITEM_QTD": numeroItem,
                        "COMANDA_ITEM_VALOR_UNT": infoProdutoItem.tpiPraticado,
                        "UCV_CODIGO": infoProdutoItem.ucvCodigo,
                        "COMANDA_ITEM_DATA_INSERCAO": dataHoraAtual,
                      };

                      var bodyJson = json.encode(dados);

                      Response response = await http.post(
                        baseUrl,
                        body: bodyJson,
                        headers: {"Content-type": "application/json"},
                      );
                      var retornoDados = jsonDecode(response.body);

                      comanda_item_codigo = retornoDados["COMANDA_ITEM_CODIGO"];
                    }

                    void _addObservacao(int codigo, String descObs) async {
                      var baseUrl = Uri.parse(
                          '${ParametrosApi.apiUrl}inserir-observacao');
                      var dados = {
                        "CODIGO_ITEM_COMANDA": codigo,
                        "OBSERVACAO_ITEM_DESCRICAO": descObs
                      };

                      var bodyJson = json.encode(dados);

                      Response response = await http.post(
                        baseUrl,
                        body: bodyJson,
                        headers: {"Content-type": "application/json"},
                      );
                      var retornoDados = jsonDecode(response.body);
                    }

                    await _addItemCarrinho();

                    if (observacaoSeleciondas.length > 0) {
                      print(comanda_item_codigo);

                      observacaoSeleciondas.forEach((observacao) {
                        var codigo = comanda_item_codigo;
                        _addObservacao(codigo, observacao.toString());
                      });
                    } else {
                      print('Sem observações');
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.greenAccent,
                        content: Text('ITEM INSERIDO COM SUCESSO'),
                      ),
                    );
                    print('ITEM INSERIDO');
                    observacaoSeleciondas = [];
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                            'FAVOR SELECIONAR NO MINIMO ${infoProdutoItem.proQtdObsObrigatorias} OPÇÕES'),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _addObservacao() async {
  var baseUrl = Uri.parse('${ParametrosApi.apiUrl}inserir-observacao');
  var dados = {
    "CODIGO_ITEM_COMANDA": comanda_item_codigo,
    "OBSERVACAO_ITEM_DESCRICAO": "BEM PESADO"
  };

  var bodyJson = json.encode(dados);

  Response response = await http.post(
    baseUrl,
    body: bodyJson,
    headers: {"Content-type": "application/json"},
  );
  var retornoDados = jsonDecode(response.body);
}
