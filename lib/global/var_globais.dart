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
