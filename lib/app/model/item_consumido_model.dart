class ItemConsumidoModel {
  int proCodigo;
  String proDescricao;
  int citQtdItens;
  double citValorUntSemDesc;
  double citValorTot;

  ItemConsumidoModel(
      {this.proCodigo,
      this.proDescricao,
      this.citQtdItens,
      this.citValorUntSemDesc,
      this.citValorTot});

  ItemConsumidoModel.fromJson(Map<String, dynamic> json) {
    proCodigo = json['proCodigo'];
    proDescricao = json['proDescricao'];
    citQtdItens = json['citQtdItens'];
    citValorUntSemDesc = json['citValorUntSemDesc'];
    citValorTot = json['citValorTot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['proCodigo'] = this.proCodigo;
    data['proDescricao'] = this.proDescricao;
    data['citQtdItens'] = this.citQtdItens;
    data['citValorUntSemDesc'] = this.citValorUntSemDesc;
    data['citValorTot'] = this.citValorTot;
    return data;
  }
}
