import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api1 extends StatefulWidget {
  const Api1({super.key});

  @override
  State<Api1> createState() => _Api1State();
}

class _Api1State extends State<Api1> {
    List<dynamic> users = []; 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function();
  }
  void function() async{
    Dio dio = Dio();
    String data = 'https://jsonplaceholder.typicode.com/users';

    try {
      
      Response response = await dio.get(data);

      if (response.statusCode == 200) {
        setState(() {
          users = response.data; 
        
        });
      }
    } catch (e) {}
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index){
         var user = users[index]; 
      return Card(
        child: ListTile(leading: CircleAvatar(radius: 20,
          backgroundColor: Colors.yellow,
          child: Text(user['name'][0]),),
          title: Text(user['name']),
        subtitle: Text(user['email']),),
      );
    }),);
  }
}