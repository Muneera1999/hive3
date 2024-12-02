import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Postapi2 extends StatefulWidget {
  const Postapi2({super.key});

  @override
  State<Postapi2> createState() => _Postapi2State();
}

class _Postapi2State extends State<Postapi2> {
  String value = 'details';
  final Dio dio = Dio();
  Future<void>sentdata()async{
    try{
      final values = await dio.post('https://jsonplaceholder.typicode.com/posts',
      data: {
        'Name':"John",
        'Age':25,
        "district":"trissur"
    });
    {setState(() {
        value = 'Details : ${values.data}';
      });}
      
      }catch(e){setState(() {
        value = "Error: $e";
        
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){sentdata();},
           child: Text('Click for showing details',),style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white ),),
            SizedBox(height: 20,),
           Text(value,style: TextStyle(fontSize: 18),)
        ],
      ),
    ),);
  }
}