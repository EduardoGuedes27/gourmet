import 'package:gourmet_mesa/global/var_globais.dart';
import 'package:http/http.dart' as http;

class ItemCarrinhoApi {
  static Future deleteItemCarrinho() async {
    var url = Uri.parse(
        "${dadosApi.apiUrl}remover-item/${parametrosApi.codigoProduto}");
    return await http.get(url);
  }
}
