// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/core/styles/app_styles.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/pages/carrinho_pagina.dart';
import 'package:gourmet_mesa/app/pages/finalizar_compra_pagina.dart';
import 'package:gourmet_mesa/app/pages/detalhe_produto_pagina.dart';
import 'package:gourmet_mesa/app/pages/inicial_pagina.dart';
import 'package:gourmet_mesa/app/pages/qr_code_teste.dart';
import 'package:gourmet_mesa/app/provider/categoria_provider.dart';
import 'package:gourmet_mesa/app/provider/produto_provider.dart';
import 'package:gourmet_mesa/app/utils/rotas_pages.dart';
import 'package:provider/provider.dart';

class GourmetVix extends StatelessWidget {
  const GourmetVix();
  static const _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
    borderSide: BorderSide(color: PaletaCores.corTextoLeve),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProdutoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CarrinhoModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Gourmet Vix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: AppStyles().botaoPrimario,
          ),
          primaryColor: PaletaCores.corPrimaria,
          colorScheme: ColorScheme.fromSeed(
            seedColor: PaletaCores.corPrimaria,
            primary: PaletaCores.corPrimaria,
            secondary: PaletaCores.corSecundaria,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.all(13),
            border: _defaultBorder,
            enabledBorder: _defaultBorder,
            focusedBorder: _defaultBorder,
          ),
        ),
        initialRoute: '/homepage',
        routes: {
          AppRoutes.HOME_PAGE: (ctx) => const homePage(),
          AppRoutes.DETALHE_PRODUTO: (ctx) => const DetalheProdutoPagina(),
          AppRoutes.CART_PAGE: (ctx) => const CarrinhoPagina(),
          AppRoutes.CHECKOUT: (ctx) => const FinalizarCompraPagina(),
          AppRoutes.QR_CODE: (ctx) => const MyWidget(),
        },
      ),
    );
  }
}
