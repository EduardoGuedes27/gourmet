// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:gourmet_mesa/app/apis/post/adicionar_item_carrinho.dart';
import 'package:gourmet_mesa/app/apis/post/adicionar_observacao_item.dart';
import 'package:gourmet_mesa/app/core/dados_globais.dart';
import 'package:gourmet_mesa/app/core/styles/cores_style.dart';
import 'package:gourmet_mesa/app/model/carrinho_model.dart';
import 'package:gourmet_mesa/app/model/produtos_categoria_model.dart';
import 'package:gourmet_mesa/app/pages/componentes/observacao_produto_componente.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BarraAdicionarItemComponente extends StatefulWidget {
  const BarraAdicionarItemComponente({Key key}) : super(key: key);

  @override
  State<BarraAdicionarItemComponente> createState() =>
      _BarraAdicionarItemComponenteState();
}

class _BarraAdicionarItemComponenteState
    extends State<BarraAdicionarItemComponente> {
  @override
  Widget build(BuildContext context) {
    final carrinhoProvider = Provider.of<CarrinhoModel>(context);
    final DadosProdutoSelecionado =
        ModalRoute.of(context).settings.arguments as infoProduto;

    return Row(
      children: [
        Container(
          height: 68,
          padding: EdgeInsets.all(8),
          //width: context.percentWidth(0.5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (ParametrosRecebidosApi.quantidade_item <= 1) {
                        } else {
                          ParametrosRecebidosApi.quantidade_item--;
                        }
                      });
                    },
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${ParametrosRecebidosApi.quantidade_item.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                    color: PaletaCores.corSecundaria,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        ParametrosRecebidosApi.quantidade_item++;
                      });
                    },
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: PaletaCores.corSecundaria,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 60,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () async {
                DataHoraAtual();
                if (observacaoSeleciondas.length >=
                    DadosProdutoSelecionado.proQtdObsObrigatorias) {
                  carrinhoProvider.addItem(
                    ProdutosCategoriaModel(
                      catCodigo: DadosProdutoSelecionado.catCodigo,
                      proCodigo: DadosProdutoSelecionado.proCodigo,
                      proDescricao: DadosProdutoSelecionado.proDescricao,
                      tpiPraticado: DadosProdutoSelecionado.tpiPraticado,
                      ucvCodigo: DadosProdutoSelecionado.ucvCodigo,
                    ),
                  );

                  await addItemCarrinhoPost(
                    DadosProdutoSelecionado.proCodigo,
                    ParametrosRecebidosApi.quantidade_item,
                    DadosProdutoSelecionado.tpiPraticado,
                    DadosProdutoSelecionado.ucvCodigo,
                  );

                  if (observacaoSeleciondas.length > 0) {
                    int _codigoItemComanda =
                        ParametrosRecebidosApi.comanda_item_codigo;
                    observacaoSeleciondas.forEach((observacao) {
                      addObservacao(_codigoItemComanda, observacao.toString());
                    });
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.greenAccent,
                      content: Text('ITEM INSERIDO COM SUCESSO'),
                    ),
                  );

                  observacaoSeleciondas = [];
                  ParametrosRecebidosApi.quantidade_item = 1;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                          'FAVOR SELECIONAR NO MINIMO ${DadosProdutoSelecionado.proQtdObsObrigatorias} OPÇÕES'),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Adicionar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: 10),
                  AutoSizeText(
                    'R\$ ${(DadosProdutoSelecionado.tpiPraticado * ParametrosRecebidosApi.quantidade_item).toStringAsFixed(2)}',
                    maxFontSize: 13,
                    minFontSize: 5,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
