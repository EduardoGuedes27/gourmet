import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:http/http.dart' as http;

class ItemCarrinhoApi {
  static Future deleteItemCarrinho() async {
    var url = Uri.parse(
        "${ParametrosApi.apiUrl}remover-item/${ParametrosApi.codigoProduto}");
    return await http.get(url);
  }
}
