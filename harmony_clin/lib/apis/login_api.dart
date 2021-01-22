import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:harmony_clin/Classes/token.dart';
import 'package:http/io_client.dart';

class LoginApi {
  static Future<Token> login(String cpf, String password) async {
    HttpClient client = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    var ioClient = new IOClient(client);

    var url = Uri.parse('https://192.168.118.2:44307/api/Login/LoginAdm');

    var header = {"Content-Type": "application/json"};

    Map params = {
      "cpf": cpf,
      "senha": password,
    };
    var token;

    var _body = json.encode(params);
    print("json enviado : $_body");

    http.Response response =
        await ioClient.post(url, headers: header, body: utf8.encode(_body));

    print('Response status: ${response.statusCode}');

    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      token = Token.fromJson(mapResponse);
    } else {
      token = null;
    }
    return token;
  }
}
