import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive3/modelclass.dart';

class Apimoselclass2 extends StatefulWidget {
  const Apimoselclass2({super.key});

  @override
  State<Apimoselclass2> createState() => _Apimoselclass2State();
}

class _Apimoselclass2State extends State<Apimoselclass2> {
  Dio dio = Dio();
  String url = 'https://dummyjson.com/products/1';
  Product? _product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function();
  }
  Future<void>function()async{
    try{
    Response response = await dio.get(url);
   setState(() {
      _product = Product.fromJson(response.data);
   });
    }catch(error){
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
     _product == null ?CircularProgressIndicator() :
      ListView(
        children: [
          Center(child: Text('${_product?.title}')),
          Container(
            child: Column(
            children: [
              Image.network(
_product!.thumbnail,
height: 100,
),
              
              Text('Brand  : ${_product?.brand}'),
              Text('rating : ${_product?.rating}'),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.currency_rupee,size: 12,),
                  Text("${_product?.price}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  Text(' M.R.P'),
                  SizedBox(width: 10,),
                  Text("(${_product?.discountPercentage} % off)")
                ],
              )
            ],
          ),)
        ],
      )
  
     );
  }
}