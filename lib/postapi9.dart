import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Postapi9 extends StatefulWidget {
  const Postapi9({super.key});

  @override
  State<Postapi9> createState() => _Postapi9State();
}

class _Postapi9State extends State<Postapi9> {
  String value = 'details';
  final Dio dio = Dio();
  Future<void>function()async{
    try{
     final  values = await dio.post('https://jsonplaceholder.typicode.com/posts',
     data:{ 'a':'z',
     'b': 'y'});
     setState(() {
  value = '${values.data}';
     });
    }catch(e){
      setState(() {
        value = '$e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        ElevatedButton(onPressed: (){function();}, child: Text('enter')),
        Text(value)
      ],
    ),);
  }
}