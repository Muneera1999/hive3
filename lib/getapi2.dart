import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Getapi2 extends StatefulWidget {
  const Getapi2({super.key});

  @override
  State<Getapi2> createState() => _Getapi2State();
}

class _Getapi2State extends State<Getapi2> {
  List<dynamic>values = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadfunction();
  }
  void loadfunction()async{
    Dio dio = Dio();
    String url = 'https://reqres.in/api/users?delay=3';
    try{
      Response response = await dio.get(url);
      if(response.statusCode == 200){
      setState(() {
          values = response.data['data'];
      });

      }
    }
    catch(e){}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemCount: values.length,
      itemBuilder: (BuildContext context, int index){
        var value = values[index];
      return Card(child: ListTile(leading: CircleAvatar(radius: 20,
        backgroundImage: NetworkImage(value['avatar']),),
        title: Text('${value['first_name']} ${value['last_name']}'),
        subtitle: Text(value["email"]),
        ),
        );
    }),);
  }
}