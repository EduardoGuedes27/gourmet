class CategoriasModel {
  int catcodigo;
  String catdescricao;

  CategoriasModel({this.catcodigo, this.catdescricao});

  CategoriasModel.fromJson(Map<String, dynamic> json) {
    catcodigo = json['catcodigo'];
    catdescricao = json['catdescricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catcodigo'] = this.catcodigo;
    data['catdescricao'] = this.catdescricao;
    return data;
  }
}
