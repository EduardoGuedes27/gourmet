import 'dart:convert';

import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:gourmet_mesa/pages/home_page.dart';
import 'package:http/http.dart' as http;

class ItemConsumidoApi {
  static Future getItemConsumido() async {
    var url =
        Uri.parse("${dadosApi.apiUrl}listar-item-consumido/${codigoComanda}");
    return await http.get(url);
  }
}
