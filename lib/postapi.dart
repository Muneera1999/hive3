

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dio POST Example'),
        ),
        body: PostExample(),
      ),
    );
  }
}

class PostExample extends StatefulWidget {
  @override
  _PostExampleState createState() => _PostExampleState();
}

class _PostExampleState extends State<PostExample> {
  final Dio _dio = Dio();
  String _response = "Response will appear here";

  Future<void> sendData() async {
    try {
      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {'email' :'abcd@gmail.com',
          "title": "Hello World",
          "body": "This is a sample post.",
          "userId": 1,
        },
      );

      setState(() {
        _response = "Response: ${response.data}";
      });
    } catch (e) {
      setState(() {
        _response = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: sendData,
            child: Text('Send POST Request'),
          ),
          SizedBox(height: 20),
          Text(_response, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}