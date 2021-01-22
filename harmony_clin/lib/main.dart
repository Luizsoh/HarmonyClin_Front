import 'package:flutter/material.dart';
import 'package:harmony_clin/pages/login_page.dart';
import 'package:harmony_clin/apis/imagens_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Harmony Clin teste',
        theme: ThemeData(
            primarySwatch: NavBarBase,
            scaffoldBackgroundColor: const Color(0xfff1e5e3)),
        home: MyHomePage(
          title: 'Harmony Clin tese',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<Widget> carousel = _buildCarousel();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          )
        ],
      ),
      body: Center(
          child: new FutureBuilder<Widget>(
        future: carousel,
        initialData: Text("Carregando ...."),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            debugPrint('valor retornado: ${snapshot.data}');
            return new Container(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              width: double.infinity,
              child: snapshot.data,
            );
          } else {
            return new CircularProgressIndicator();
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Widget> _buildCarousel() async {
    var imagens = await ImagensApi.listar();
    return CarouselSlider(
      options: CarouselOptions(
          height: 400,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal),
      items: <Widget>[
        for (var i = 0; i < imagens.length; i++)
          Container(
            margin: const EdgeInsets.only(top: 20.0, left: 20.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagens[i].filePath),
                fit: BoxFit.fitHeight,
              ),
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
      ],
    );
  }
}
