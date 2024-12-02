import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:hive3/modelclass3.dart';

class Apimodelclass3 extends StatefulWidget {
  const Apimodelclass3({super.key});

  @override
  State<Apimodelclass3> createState() => _Apimodelclass3State();
}

class _Apimodelclass3State extends State<Apimodelclass3> {
  List<Pproduct>companies = [];
    Dio dio = Dio();
  String url = 'https://fake-json-api.mock.beeceptor.com/companies';
  Pproduct? product;
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
    companies = data.map((company) => Pproduct.fromJson(company)).toList();
      // product = Pproduct.fromJson(response.data);

   });
    }catch(error){
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   companies.isEmpty ?CircularProgressIndicator() : ListView.builder(itemCount: companies.length,
       itemBuilder: (BuildContext context, int index){
              return ListTile(title: Text('${companies[index].name}'),);
            })
   
    );
  }
}