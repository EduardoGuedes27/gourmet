class ObservacaoProduto {
  int pobCodigo;
  int proCodigo;
  String pobDescricao;
  bool check = false;

  ObservacaoProduto({this.pobCodigo, this.proCodigo, this.pobDescricao});

  ObservacaoProduto.fromJson(Map<String, dynamic> json) {
    pobCodigo = json['pobCodigo'];
    proCodigo = json['proCodigo'];
    pobDescricao = json['pobDescricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pobCodigo'] = this.pobCodigo;
    data['proCodigo'] = this.proCodigo;
    data['pobDescricao'] = this.pobDescricao;

    return data;
  }
}
