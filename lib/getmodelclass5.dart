import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Getmodelclass5 extends StatefulWidget {
  const Getmodelclass5({super.key});

  @override
  State<Getmodelclass5> createState() => _Getmodelclass5State();
}

class _Getmodelclass5State extends State<Getmodelclass5> {
  Dio dio = Dio();
  String url = 'https://jsonplaceholder.typicode.com/posts';
  Product? product;
  List<Product>details = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function();
  }
  Future<void>function()async{
    try{
      Response response = await dio.get(url);
      List informations = response.data;
      setState(() {
        details = informations.map((detail) =>Product.fromJson(detail)).toList();
      });
    }catch(error){
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemCount: details.length,
      itemBuilder: (BuildContext context, int index){
      return Column(
        children: [
          ListTile(
            leading: Text('${details[index].id}',),
            title: Text('${details[index].title}',style: TextStyle(color: Colors.red),),
             subtitle:  Text('${details[index].body}'),
          ),
          Divider()
        ],
      );
    }),);
  }
}



class Product {
  int? userId;
  int? id;
  String? title;
  String? body;

  Product({this.userId, this.id, this.title, this.body});

  Product.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
