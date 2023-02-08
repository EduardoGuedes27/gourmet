import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:gourmet_mesa/app/core/dados_globais.dart';

void addItemCarrinhoPost(
  int codigo_produto,
  int quantidade,
  double preco_unitario,
  int ucv_codigo,
) async {
  var baseUrl = Uri.parse('${ParametrosApi.apiUrl}inserir-item');
  var dados = {
    "COMANDA_CODIGO": ParametrosRecebidosApi.comanda_codigo,
    "PRO_CODIGO": codigo_produto,
    "COMANDA_ITEM_QTD": quantidade,
    "COMANDA_ITEM_VALOR_UNT": preco_unitario,
    "UCV_CODIGO": ucv_codigo,
    "COMANDA_ITEM_DATA_INSERCAO": dataHoraAtual,
  };

  var bodyJson = json.encode(dados);

  Response response = await http.post(
    baseUrl,
    body: bodyJson,
    headers: {"Content-type": "application/json"},
  );
  var retornoDados = jsonDecode(response.body);

  ParametrosRecebidosApi.comanda_item_codigo =
      retornoDados["COMANDA_ITEM_CODIGO"];
}
