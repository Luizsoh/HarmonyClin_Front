import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:harmony_clin/Classes/token.dart';

class LoginApi {
  static Future<Token> login(String cpf, String password) async {
    var url = 'https://localhost:44335/api/Login/LoginAdm';

    var header = {"Content-Type": "application/json"};

    Map params = {
      "cpf": cpf,
      "senha": password,
    };
    var token;

    var _body = json.encode(params);
    print("json enviado : $_body");

    var response = await http.post(url, headers: header, body: _body);

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
