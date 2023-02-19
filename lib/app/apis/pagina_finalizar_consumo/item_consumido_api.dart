import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:http/http.dart' as http;

class ItemConsumidoApi {
  static Future getItemConsumido() async {
    var url = Uri.parse(
        "${ParametrosApi.apiUrl}listar-item-consumido/${ParametrosRecebidosApi.comanda_codigo}");
    return await http.get(url);
  }
}
