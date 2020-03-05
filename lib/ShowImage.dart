import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class App extends StatefulWidget {
  var Imagem;

  App(var ima){
    Imagem = ima;
  }
  @override
  _App createState() => _App(Imagem);
}

class _App extends State<App> {
  var Imagem;
  var aux1;
  var Ima;

  _App(var ima){
    Imagem = ima;
    print("Ola mundo");
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      body: PhotoView(
        imageProvider: new FileImage(Imagem),
      ),
    );
  }
}