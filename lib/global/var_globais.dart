import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

/*
class dadosApi {
  static String apiUrl = 'http://cellecia.inforvix.net.br:9000/';
}*/

class dadosApi {
  static String apiUrl = 'http://localhost:9000/';
  //static String apiUrl = 'http://cellecia.inforvix.net.br:9000/';
  //static String apiUrl = 'https://c6d4-2804-1b3-9101-f4a6-ccbf-300d-b06c-25cb.sa.ngrok.io/';
}

class parametrosApi {
  static int codigoCategoria = 1;
  static int codigoProduto = 1;
}

class inputAbrirMesa {
  static String numero_comanda = '';
  static String nome_cliente = '';
  static String local_mesa = '';
  static String data_abertura = '';
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

var dataHoraAtual = '';
//ESTA FUNÇÃO PEGA A DATA ATUAL NO FORMATO 'YYYY/MM/DD HH:MM:SS'
void DataHoraAtual() {
  var dia = DateTime.now().day.toString().padLeft(2, '0');
  var mes = DateTime.now().month.toString().padLeft(2, '0');
  var ano = DateTime.now().year.toString().padLeft(4, '0');
  var hora = DateTime.now().hour.toString().padLeft(2, '0');
  var minuto = DateTime.now().minute.toString().padLeft(2, '0');
  var segundo = DateTime.now().second.toString().padLeft(2, '0');
  dataHoraAtual = '${ano}-${mes}-${dia} ${hora}:${minuto}:${segundo}';
}
