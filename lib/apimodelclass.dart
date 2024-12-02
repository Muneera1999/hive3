
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive3/modelclass.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: MyApiScreen(),
);
}
}

class MyApiScreen extends StatefulWidget {
@override
_MyApiScreenState createState() => _MyApiScreenState();
}

class _MyApiScreenState extends State<MyApiScreen> {
Dio _dio = Dio();
String _apiUrl = 'https://dummyjson.com/products/1';
Product? _product;

@override
void initState() {
super.initState();
_getDataFromApi();
}

Future<void> _getDataFromApi() async {
try {
Response response = await _dio.get(_apiUrl);
setState(() {
_product = Product.fromJson(response.data);
print(_product?.brand);
});
} catch (error) {
print('Error fetching data: $error');
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Product Details'),
),
body: Center(
child: _product == null
? CircularProgressIndicator()
: SingleChildScrollView(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Title: ${_product?.title}'),
Text('Description: ${_product?.description}'),
Text('Price: \$${_product?.price}'),
Text('Discount: ${_product?.discountPercentage}%'),
Text('Rating: ${_product?.rating}'),
Text('Stock: ${_product?.stock}'),
Text('Brand: ${_product?.brand}'),
Text('Category: ${_product?.category}'),
SizedBox(height: 16),
Image.network(
_product!.thumbnail,
height: 100,
),
SizedBox(height: 16),
Text('Images:'),
Container(
height: 100,
child: ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: _product?.images.length,
itemBuilder: (BuildContext context, int index) {
return Padding(
padding: const EdgeInsets.all(8.0),
child: Image.network(
_product!.images[index],
height: 80,
),
);
},
),
),
],
),
),
),
);
}
}
