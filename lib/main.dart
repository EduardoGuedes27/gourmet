import 'package:flutter/material.dart';
import 'package:gourmet_mesa/model/categorias_model.dart';
import 'package:gourmet_mesa/pages/detail_product_page.dart';
import 'package:gourmet_mesa/pages/home_page.dart';
import 'package:gourmet_mesa/provider/categoria_provider.dart';
import 'package:gourmet_mesa/provider/produto_provider.dart';
import 'package:gourmet_mesa/utils/rotas_pages.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

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
      ],
      child: MaterialApp(
        title: 'Gourmet Mesa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/homepage',
        routes: {
          AppRoutes.HOME_PAGE: (ctx) => const homePage(),
          AppRoutes.DETALHE_PRODUTO: (ctx) => const DetailProductPage(),
        },
      ),
    );
  }
}
