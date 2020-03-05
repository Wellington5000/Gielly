import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:flutter/services.dart';
class Shared{
	compartilhar(var Lista) async{
		final bytes = [];
		final Aux = [];
		var Aux2;
		for(int i = 0; i < Lista.length; i++){
			Aux2 = Lista[i].toString();
			Aux2 = Aux2.replaceAll('File: \'', '');
			Aux2 = Aux2.replaceAll('\'', '');
			Aux.add(Aux2);
		}

		for(int j = 0; j < Lista.length; j++){
			bytes.add(await rootBundle.load(Aux[j]));
		}

		if(Lista.length == 1){
			await Share.file('esys images', '1.png', bytes[0].buffer.asUint8List(), 'image/png');	
		}
		else if(Lista.length == 2){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 3){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 4){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
			'4.png': bytes[3].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 5){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
			'4.png': bytes[3].buffer.asUint8List(),
			'5.png': bytes[4].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 6){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
			'4.png': bytes[3].buffer.asUint8List(),
			'5.png': bytes[4].buffer.asUint8List(),
			'6.png': bytes[5].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 7){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
			'4.png': bytes[3].buffer.asUint8List(),
			'5.png': bytes[4].buffer.asUint8List(),
			'6.png': bytes[5].buffer.asUint8List(),
			'7.png': bytes[6].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 8){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
			'4.png': bytes[3].buffer.asUint8List(),
			'5.png': bytes[4].buffer.asUint8List(),
			'6.png': bytes[5].buffer.asUint8List(),
			'7.png': bytes[6].buffer.asUint8List(),
			'8.png': bytes[7].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 9){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
			'4.png': bytes[3].buffer.asUint8List(),
			'5.png': bytes[4].buffer.asUint8List(),
			'6.png': bytes[5].buffer.asUint8List(),
			'7.png': bytes[6].buffer.asUint8List(),
			'8.png': bytes[7].buffer.asUint8List(),
			'9.png': bytes[8].buffer.asUint8List(),
       		},'*/*');
		}
		else if(Lista.length == 10){
			await Share.files('esys images', 
			{'1.png': bytes[0].buffer.asUint8List(),
			'2.png': bytes[1].buffer.asUint8List(),
			'3.png': bytes[2].buffer.asUint8List(),
			'4.png': bytes[3].buffer.asUint8List(),
			'5.png': bytes[4].buffer.asUint8List(),
			'6.png': bytes[5].buffer.asUint8List(),
			'7.png': bytes[6].buffer.asUint8List(),
			'8.png': bytes[7].buffer.asUint8List(),
			'9.png': bytes[8].buffer.asUint8List(),
			'10.png': bytes[9].buffer.asUint8List(),
       		},'*/*');
		}
	}
}
