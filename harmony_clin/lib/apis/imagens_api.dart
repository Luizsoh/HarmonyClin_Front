import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:harmony_clin/Classes/imagem.dart';

class ImagensApi {
  static Future<List<Imagem>> listar() async {
    var url = 'https://192.168.100.11:44307/api/Imagem/ListarImagens';

    var header = {"Content-Type": "application/json"};

    var imagens;
    var response = await http.get(url, headers: header);

    print('Response teste: ${response.statusCode}');

    if (response.statusCode == 200) {
      imagens = (json.decode(response.body) as List)
          .map((i) => Imagem.fromJson(i))
          .toList();
      print("fromJson: $imagens");
    } else {
      imagens = null;
    }
    return imagens;
  }
}
