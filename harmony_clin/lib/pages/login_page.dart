import 'package:flutter/material.dart';
import 'package:harmony_clin/utilities/constants.dart';
import 'package:harmony_clin/apis/login_api.dart';

import 'package:harmony_clin/utilities/alert.dart';

const MaterialColor NavBarBase = MaterialColor(
  corBaseNavegacao,
  <int, Color>{
    50: Color(0xFFfbd0c8),
    100: Color(0xFFf1c1b8),
    200: Color(0xFFfcd8d1),
    300: Color(0xFFfcd8d1),
    400: Color(0xFFfcd8d1),
    500: Color(corBaseNavegacao),
    600: Color(0xFFfcd8d1),
    700: Color(0xFFfcd8d1),
    800: Color(0xFFfcd8d1),
    900: Color(0xFFfcd8d1),
  },
);
const int corBaseNavegacao = 0xFFf1c1b8;

final _crtlLogin = TextEditingController();
final _crtlSenha = TextEditingController();
final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Login'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: NavBarBase,
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Image.asset('logos/icone_appbar.png', fit: BoxFit.fitHeight),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    _buildCPFTF(),
                    SizedBox(height: 30.0),
                    _buildPasswordTF(),
                    _buildEsqueciSenhaTF(),
                    _buildRaisedButton(context),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildEsqueciSenhaTF() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {},
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Esqueceu a senha?',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildCPFTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CPF',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 10.0),
                hintText: 'Digite o CPF',
                prefixIcon: Icon(Icons.account_circle_outlined)),
            controller: _crtlLogin,
            validator: _validaLogin,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 10.0),
                  hintText: 'Digite a senha',
                  prefixIcon: Icon(Icons.lock)),
              controller: _crtlSenha,
              validator: _validaSenha,
              obscureText: true),
        ),
      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        color: Color(0xFFf1c1b8),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          'Login',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          _clickButton(context);
        },
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  String _validaLogin(String texto) {
    if (texto.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  String _validaSenha(String texto) {
    if (texto.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  Future<void> _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return null;
    }

    String login = _crtlLogin.text;
    String senha = _crtlSenha.text;

    print("login: $login senha: $senha");

    var token = await LoginApi.login(login, senha);

    if (token != null) {
      print("$token");
      _navegaHomepage(context);
    } else {
      alert(context, "Login Inválido", "Login");
    }
  }

  _navegaHomepage(BuildContext context) {
    Navigator.pop(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MyApp()),
    // );
  }
}
