import 'package:flutter/material.dart';
import 'models/materias.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Grid.dart';

void main() => runApp(MyApp());
//---------------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
//---------------------------------------------------------------------------------
class MyHomePage extends StatefulWidget {
  //CRIA UMA LISTA DE ITENS
  var items = new List<Item>();
  //INICIALIZA A LISTA AO CHAMAR O MÉTODO CONSTRUTOR
  MyHomePage(){
    items = []; 
  }
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
//---------------------------------------------------------------------------------
class _MyHomePageState extends State<MyHomePage> {
  //CRIA UMA VARIÁVEL PARA PEGAR O TEXTO DIGITADO
  var newTaskCtrl = TextEditingController();
  //MÉTODO PARA CARREGAR O NOME DAS MATÉRIAS
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if(data != null){
      //PERCORRE A LISTA E ADICIONA NA MINHA LISTA DE ITENS
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
          widget.items = result;
      });
    }
  }
//MÉTODO PARA SALVAR OS ARQUIVOS DA LISTA
  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }
//MÉTODO PARA ADICIONAR TENS NA LISTA
  void add(){
    setState(() {
      widget.items.add(Item(title: newTaskCtrl.text));
      newTaskCtrl.clear();
      save();
    });
  }
  //REMOVE O ITEM
  void remove(int index){
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }
//CARREGA A MINHA LISTA DE ITENS AO ABRIR O APP
  _MyHomePageState(){
    load();
  }
//CRIA A JANELA PARA ADICIONAR UMA NOVA MATÉRIA
  showAlertDialog1(BuildContext context) { 
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: add,
    );
    //CONFIGURA O ALERT DIALOG
    AlertDialog alerta = AlertDialog(
      title: Text("INSIRA O NOME DA MATÉRIA"),
      content: TextFormField(
        controller: newTaskCtrl,
        keyboardType: TextInputType.text,
      ),
      actions: [
        okButton,
      ],
    );
    //EXIBE O ALERT DIALOG 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("Matérias"),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index){
          final item = widget.items[index];
          return Dismissible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ButtonTheme(
                      height:60.0,
                      child: RaisedButton(
                        onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Grid(item.title)),)},
                        shape: new RoundedRectangleBorder(borderRadius:
                        new BorderRadius.circular(30.0)),
                        child: Text(item.title, style: TextStyle(color: Colors.blue, fontSize: 25),), //Text
                        color:Colors.white,
                      ),
                    ),
                    Divider(),
                  ]
                ),
              ),
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.blue,
            ),
            onDismissed: (direction) {
              remove(index);
            },
          );  
        },
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: (){showAlertDialog1(context);},
            tooltip: 'Inserir matéria',
            child: Icon(Icons.add)
      ), 
    );
  }
}


