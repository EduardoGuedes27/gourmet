import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

class dadosApi {
  static String apiUrl = 'http://localhost:9000/';
}

class parametrosApi {
  static int codigoCategoria = 1;
  static int codigoProduto = 1;
}

class inputAbrirMesa {
  static String numero_comanda = '';
  static String nome_cliente = '';
  static String local_mesa = '';
  static String data_abertura = '2022-12-30 10:10:10';
}

class infoProduto {
  final int catCodigo;
  final int proCodigo;
  final String proDescricao;
  final double tpiPraticado;
  final int ucvCodigo;
  final int proQtdObsObrigatorias;
  final String proObs;
  final String caminhoImgUrl;
  infoProduto(
    this.catCodigo,
    this.proCodigo,
    this.proDescricao,
    this.tpiPraticado,
    this.ucvCodigo,
    this.proQtdObsObrigatorias,
    this.proObs,
    this.caminhoImgUrl,
  );
}
