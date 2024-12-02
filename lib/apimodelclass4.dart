import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive3/modelclass4.dart';

class Apimodelclass4 extends StatefulWidget {
  const Apimodelclass4({super.key});

  @override
  State<Apimodelclass4> createState() => _Apimodelclass4State();
}

class _Apimodelclass4State extends State<Apimodelclass4> {
  Dio dio = Dio();
  String url = 'https://www.simplifiedcoding.net/demos/marvel/';
  Abcd? abcd;
  List<Abcd>datas = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function();
  }
  Future<void>function()async{
    try{
      Response response = await dio.get(url);
      List data = response.data;
      setState(() {
        datas = data.map((dat) => Abcd.fromJson(dat)).toList();
      });
    }catch(error){
      print(error);
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:datas.isEmpty ?CircularProgressIndicator(): ListView.builder(itemCount: datas.length,
      itemBuilder: (BuildContext context, int index){
      return 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Column(
            children: [
              Text('${datas[index].name}',style: TextStyle(fontSize: 20),),
              Text('Real Name : ${datas[index].realname}'),
              Text('Team : ${datas[index].team}'),
              Text('Created by : ${datas[index].createdby}'),
              Text('${datas[index].bio}'),
            Image.network('${datas[index].imageurl}')
        
            ],
          ),),
      );
      
    }) ,);
  }
}