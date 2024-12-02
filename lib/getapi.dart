import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Getapi extends StatefulWidget {
  const Getapi({super.key});

  @override
  State<Getapi> createState() => _GetapiState();
}

class _GetapiState extends State<Getapi> {
  List<dynamic>users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startfuction();
    
  }
  void startfuction() async{
    Dio dio = Dio();
    String url = 'https://fake-json-api.mock.beeceptor.com/companies';
      try{
        Response resopnse = await dio.get(url);
        if(resopnse.statusCode == 200){
          setState(() {
            users = resopnse.data;
          }
          );
        }
      }
      catch(e){}
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemCount: users.length,
      itemBuilder: (BuildContext context,int index){
        var user =users[index];
      return Card(
        child: ListTile(leading: CircleAvatar(radius: 20,backgroundImage: NetworkImage(user['logo'])),
          title: Text('${user['name']} from ${user['country']}'),
        subtitle: Text(user['address']),),
      );
    }),);
  }
}