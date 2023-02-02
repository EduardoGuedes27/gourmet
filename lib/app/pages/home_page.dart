// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, missing_return, prefer_const_constructors

import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/model/categorias_model.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/badge.dart';
import 'package:gourmet_mesa/app/pages/componentes/categorias_componente.dart';
import 'package:gourmet_mesa/app/pages/componentes/produtos_componente.dart';
import 'package:gourmet_mesa/app/utils/rotas_pages.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  const homePage({Key key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _informarDadosMesa(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _numeroController = TextEditingController();
        final TextEditingController _nomeController = TextEditingController();
        final TextEditingController _localController = TextEditingController();

        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Esta comanda esta livre! preencha os dados para prosseguir'),
                TextFormField(
                  controller: _numeroController,
                  decoration: InputDecoration(hintText: "NUMERO COMANDA"),
                  validator: (value) {
                    return value.isNotEmpty
                        ? null
                        : "Favor informar o numero da Comanda";
                  },
                ),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(hintText: "NOME"),
                  validator: (value) {
                    return value.isNotEmpty
                        ? null
                        : "Favor informar o seu Nome";
                  },
                ),
                TextFormField(
                  controller: _localController,
                  decoration: InputDecoration(hintText: "LOCAL MESA"),
                  validator: (value) {
                    return value.isNotEmpty ? null : "Favor informar o Andar";
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                DataHoraAtual();

                inputAbrirMesa.numero_comanda =
                    _numeroController.text.toString();
                inputAbrirMesa.nome_cliente = _nomeController.text.toString();
                inputAbrirMesa.local_mesa = _localController.text.toString();
                inputAbrirMesa.data_abertura = dataHoraAtual.toString();

                if (_formKey.currentState.validate()) {
                  _abrirMesa();
                  Navigator.pop(context);
                }
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final carrrinhoProvider = Provider.of<CarrinhoModel>(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Seja Bem Vindo'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(
                'Carrinho',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_checkout),
              title: Text(
                'Pedir Conta',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.CHECKOUT);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: PaletaCores.corTexto,
            ),
          ),
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
          IconButton(
            icon: Icon(Icons.open_in_browser, color: PaletaCores.corTexto),
            onPressed: () {
              _informarDadosMesa(context);
            },
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
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: SelectableText(
              'Cardapio',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          CategoriasComponente(),
          ProdutosComponente(),
        ],
      ),
    );
  }
}

void _abrirMesa() async {
  DataHoraAtual();
  var baseUrl = Uri.parse('${ParametrosApi.apiUrl}/abrir-comanda');
  var dados = {
    "NUMERO_COMANDA": inputAbrirMesa.numero_comanda,
    "NOME_CLIENTE": inputAbrirMesa.nome_cliente,
    "LOCAL_MESA": inputAbrirMesa.local_mesa,
    "DATA_ABERTURA": inputAbrirMesa.data_abertura,
  };

  var bodyJson = json.encode(dados);

  Response response = await http.post(
    baseUrl,
    body: bodyJson,
    headers: {"Content-type": "application/json"},
  );
  var retornoDados = json.decode(response.body);
  int retorno_codigo = retornoDados["CON_CODIGO"];

  codigoComanda = retorno_codigo;

  print(retorno_codigo);
}

var codigoComanda;
