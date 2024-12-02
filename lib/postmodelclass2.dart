import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive3/pmodelclass2.dart';

class Postmodelclass2 extends StatefulWidget {
  const Postmodelclass2({super.key});

  @override
  State<Postmodelclass2> createState() => _Postmodelclass2State();
}

class _Postmodelclass2State extends State<Postmodelclass2> {
  String message ='';
  TextEditingController cfirst = TextEditingController();
  TextEditingController clast = TextEditingController();
  TextEditingController cmail = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController ctele = TextEditingController();
  Future<void>enter()async{
    final dio = Dio();
    final url = 'https://fressery.b4production.com/index.php?route=api/register';
    final formdata = FormData.fromMap({'firstname': cfirst.text,
    'lastname': clast.text,
    'email': cmail.text,
    'password': cpassword.text,
    'Telephone' : ctele.text});
    try{
      final reponse = await dio.post(url,data: formdata);
      if(reponse.statusCode == 200){
        final responseData = reponse.data;
        final apiresponse = Apiresponse.fromJson(responseData);
        if(apiresponse.success == 'text_success'){
          setState(() {
            message=' successful';
            
          });
          
          
        }
        else{
          setState(() {
            message = 'failed with ${responseData}';
          });
        }
        

      }
      else {
        setState(() {
          message = 'Error: ${reponse.statusCode}';
        });
      }
      
    }catch (e) {
      // Handle any errors
      setState(() {
        message = 'Exception: $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField
          (controller: cfirst,
            decoration: InputDecoration(
            hintText: 'First Name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
        ),
           SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(controller: clast,
              decoration: InputDecoration(
            hintText: 'Last Name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
          ),
           SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(controller: cmail,
              decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
          ),
           SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(controller: cpassword,
              decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
          ),
           SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(controller: ctele,
              decoration: InputDecoration(
            hintText: 'Telephnoe Number',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){enter();}, child: Text('Enter'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
          foregroundColor: Colors.white),),
          Text(message)
      ],
    ),);
  }
}