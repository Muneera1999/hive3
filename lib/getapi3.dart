import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Getapi3 extends StatefulWidget {
  const Getapi3({super.key});

  @override
  State<Getapi3> createState() => _Getapi3State();
}

class _Getapi3State extends State<Getapi3> {
  List<dynamic>values = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startfuction();
  }
  void startfuction()async{
    Dio dio = Dio();
    String url = 'https://reqres.in/api/users?delay=3';
    try{
      Response response = await dio.get(url);
      if(response.statusCode== 200){
      setState(() {
          values = response.data['data'];
      });
      }
    }catch(e){}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context,int index){
        var value = values[index];
      return Card(child: ListTile(leading: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(value['avatar']),),
        title: Text('${value['first_name']} ${value['last_name']}',),
        subtitle: Text(value['email']),
        titleTextStyle: TextStyle(fontSize: 20),
        subtitleTextStyle: TextStyle(fontSize: 18),));
    }),);
  }
}