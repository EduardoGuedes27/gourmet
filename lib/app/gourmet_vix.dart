// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/styles/app_styles.dart';
import 'package:gourmet_mesa/app/styles/cores_style.dart';
import 'package:gourmet_mesa/app/styles/texto_styles.dart';
import 'package:gourmet_mesa/model/carrinho.dart';
import 'package:gourmet_mesa/pages/cart_page.dart';
import 'package:gourmet_mesa/pages/checkout_page.dart';
import 'package:gourmet_mesa/pages/detail_product_page.dart';
import 'package:gourmet_mesa/pages/home_page.dart';
import 'package:gourmet_mesa/provider/categoria_provider.dart';
import 'package:gourmet_mesa/provider/produto_provider.dart';
import 'package:gourmet_mesa/utils/rotas_pages.dart';
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
          create: (_) => Carrinho(),
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
          AppRoutes.DETALHE_PRODUTO: (ctx) => const DetailProductPage(),
          AppRoutes.CART_PAGE: (ctx) => const CartPage(),
          AppRoutes.CHECKOUT: (ctx) => const CheckoutPage(),
        },
      ),
    );
  }
}
