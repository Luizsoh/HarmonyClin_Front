class Imagem {
  int imgId;
  String fileName;
  String filePath;
  String titulo;
  String legenda;
  String link;
  bool status;
  Null nomePropriedade;
  Null mensagem;

  Imagem(
      {this.imgId,
      this.fileName,
      this.filePath,
      this.titulo,
      this.legenda,
      this.link,
      this.status,
      this.nomePropriedade,
      this.mensagem});

  Imagem.fromJson(Map<String, dynamic> json) {
    imgId = json['img_Id'];
    fileName = json['fileName'];
    filePath = json['filePath'];
    titulo = json['titulo'];
    legenda = json['legenda'];
    link = json['link'];
    status = json['status'];
    nomePropriedade = json['nomePropriedade'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_Id'] = this.imgId;
    data['fileName'] = this.fileName;
    data['filePath'] = this.filePath;
    data['titulo'] = this.titulo;
    data['legenda'] = this.legenda;
    data['link'] = this.link;
    data['status'] = this.status;
    data['nomePropriedade'] = this.nomePropriedade;
    data['mensagem'] = this.mensagem;
    return data;
  }
}
