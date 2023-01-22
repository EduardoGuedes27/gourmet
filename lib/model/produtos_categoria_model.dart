class Produto {
  int catCodigo;
  int proCodigo;
  String proDescricao;
  double tpiPraticado;
  int ucvCodigo;
  int proQtdObsObrigatorias;
  String caminhoImgUrl;

  Produto(
      {this.catCodigo,
      this.proCodigo,
      this.proDescricao,
      this.tpiPraticado,
      this.ucvCodigo,
      this.proQtdObsObrigatorias,
      this.caminhoImgUrl});

  Produto.fromJson(Map<String, dynamic> json) {
    catCodigo = json['catCodigo'];
    proCodigo = json['proCodigo'];
    proDescricao = json['proDescricao'];
    tpiPraticado = json['tpiPraticado'];
    ucvCodigo = json['ucvCodigo'];
    proQtdObsObrigatorias = json['proQtdObsObrigatorias'];
    caminhoImgUrl = json['caminhoImgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catCodigo'] = this.catCodigo;
    data['proCodigo'] = this.proCodigo;
    data['proDescricao'] = this.proDescricao;
    data['tpiPraticado'] = this.tpiPraticado;
    data['ucvCodigo'] = this.ucvCodigo;
    data['proQtdObsObrigatorias'] = this.proQtdObsObrigatorias;
    data['caminhoImgUrl'] = this.caminhoImgUrl;
    return data;
  }
}