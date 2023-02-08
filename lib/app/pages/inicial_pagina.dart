// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, missing_return, prefer_const_constructors

import 'dart:convert';
import 'dart:js_util';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gourmet_mesa/app/apis/post/abertura_comanda.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/model/categorias_model.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/badge_componente.dart';
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
  String id;

  void initState() {
    super.initState();
    _getIdFromURL();
  }

  void _getIdFromURL() {
    final uri = Uri.parse(window.defaultRouteName);
    setState(() {
      id = uri.queryParameters['id'];
    });
  }

  Future<void> _informarDadosMesa(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _numeroController = TextEditingController();
        final TextEditingController _nomeController = TextEditingController();
        final TextEditingController _localController = TextEditingController();
        _numeroController.text = id.toString();
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Esta comanda esta livre!'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    controller: _numeroController,
                    decoration: InputDecoration(label: Text("NUMERO COMANDA")),
                    validator: (value) {
                      return value.isNotEmpty
                          ? null
                          : "Favor informar o numero da Comanda";
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(label: Text("NOME")),
                    validator: (value) {
                      return value.isNotEmpty
                          ? null
                          : "Favor informar o seu Nome";
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _localController,
                    decoration: InputDecoration(label: Text("LOCAL MESA")),
                    validator: (value) {
                      return value.isNotEmpty ? null : "Favor informar o Andar";
                    },
                  ),
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
                  AbrirComanda();
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
