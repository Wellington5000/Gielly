import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'ShowImage.dart';
import 'dart:async';
import 'Select.dart';
import 'Share.dart';

//---------------------------------------------------------------------------------------
class Grid extends StatefulWidget {
  String NomePasta;
  Grid(String t){
    NomePasta = t;
  }
  
  @override
  _Grid createState() => _Grid(NomePasta);
}


//---------------------------------------------------------------------------------------
class _Grid extends State<Grid> {
  String _NomePasta;
  var ListaImagens;
  var im;
  int c = 0;
  var loading;
  var progress;
  var list = [];
  var selected;
  var del;
  var tamanho;
  var Aux2;
  //Método construtor para receber o nome da matéria selecionada
  _Grid(String t) {
    _NomePasta = t;
    carrega();
    _updateProgress();
  }

  @override
  void initState(){
    super.initState();
    loading = false;
    progress = 0.0;
    selected = [];
    del = [];
  }


  String RetiraAcentos(String texto){
    String comAcento = "ÁÃÂÀáãâàÉÊÈéêèÍÌíìÓÕÔÒóõôòÚÙúùÇç";
    String semAcento = "AAAAaaaaEEEeeeIIiiOOOOooooUUuuCc";

    for(int i = 0; i < texto.length; i++){
      texto = texto.replaceAll(comAcento[i].toString(), semAcento[i].toString());
    }
    return texto;
  }

  //ANIMAÇÃO DE PROGRESSO FLUTTER
  void _updateProgress(){
    const oneSec = const Duration(milliseconds: 5);
    new Timer.periodic(oneSec, (Timer t){
      setState(() {
        progress += 0.01;
        if(progress.toStringAsFixed(1) == '1.0'){
          loading = true;
          t.cancel();
          progress = 0.0;
          return;
        }  
      });
    });
  }


  Future carrega() async {
    _NomePasta = RetiraAcentos(_NomePasta);
    
    String caminho = '/storage/emulated/0/Android/data/com.example.gielly';    
    //Chama a função para criar a pasta
    String CaminhoPasta = await createFolderInAppDocDir(caminho, _NomePasta);
    ListaElementos(CaminhoPasta);
  }

//---------------------------------------------------------------------------------------
  //Método que cria a pasta
static Future <String> createFolderInAppDocDir(String caminho, nome) async {
    //App Document Directory + folder name
    final Directory _appDocDirFolder =  Directory('$caminho/$nome/');
    if(await _appDocDirFolder.exists()){ //if folder already exists return path
      return _appDocDirFolder.path;
    }else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
}

//----------------------------------------------------------------------------------------
  ListaElementos(String caminho){
    final myDir = new Directory(caminho);
    List<FileSystemEntity> ima;
    ima = myDir.listSync(recursive: true, followLinks: false);
    setState(() {
      ListaImagens = ima;
    });
    
    int tam;
    if(ListaImagens == null){
      tam = 0;
    }
    else{
      tam = ListaImagens.length;
    }
    for (int i = 0; i < tam; i++){ 
     list.add(ListItem<File>(ListaImagens[i]));
     list[i].isSelected = false;
    }   
  }

//----------------------------------------------------------------------------------------  
  //Método para tirar a foto
  File _image;
  Future getImage() async {
    //Tira a foto
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //Seleciona o caminho onde a pasta será criada
    String caminho = '/storage/emulated/0/Android/data/com.example.gielly';    
    //Chama a função para criar a pasta
    String CaminhoPasta = await createFolderInAppDocDir(caminho, _NomePasta);
    list = [];
    c = ListaImagens.length + 1;
    //Salva a foto no caminho especificado
    final File NovaImagem = await image.copy('$CaminhoPasta/image$c.png');
    ListaElementos(CaminhoPasta);
    
    //Seta o diretorio da imagem pra ela ser mostrada na tela
    setState(() {
      _image = NovaImagem;
    });
  }
  Shared s = new Shared();
  @override
  Widget build(BuildContext context) {
    if(ListaImagens == null){
      tamanho = 0;
    }
    else{
      tamanho = ListaImagens.length;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagens de $_NomePasta'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_a_photo), onPressed: getImage,),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 4.0,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.share), onPressed: () {
                  s.compartilhar(selected);
                  del = [];
                  selected = [];
                },),
                IconButton(icon: Icon(Icons.delete), onPressed: () {
                  for(int i = 1; i <= del.length; i++){
                    i--;
                    Aux2 = del[i].toString();
                    Aux2 = Aux2.replaceAll('File: \'', '');
                    Aux2 = Aux2.replaceAll('\'', '');

                    final dir = Directory(Aux2);
                    dir.deleteSync(recursive: true);

                    selected.remove(del[i]);
                    del.remove(del[i]);
                  }
                  del = [];
                  selected = [];
                  list = [];
                  carrega();
                },),
              ],
            ),
          ),
      body: loading ? GridView.count(
            crossAxisCount: 3,
            children: List.generate(tamanho, (index){
              return InkWell(
                  onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => App(ListaImagens[index])))},
                  onLongPress: (){
                    setState(() {
                      list[index].isSelected = !list[index].isSelected;
                      if(list[index].isSelected == false){
                        selected.remove(list[index].data);
                        del.remove(list[index].data);
                      }else{
                        del.add(list[index].data);
                        selected.add(list[index].data);  
                      }
                    });
                  },
                  child: Container(
                    child: new Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: list[index].isSelected ? 
                        Opacity(
                          opacity: 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.file(ListaImagens[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.file(ListaImagens[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                );
              })
            )
          : Center(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        value: progress,
                      ),
                      Text('${(progress * 100).round() }%'),
                    ],
                  )
                ),
              ),
            );
          }
        }